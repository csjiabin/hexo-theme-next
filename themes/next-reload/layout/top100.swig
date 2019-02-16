{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template %}

  {% block title %}{#
  #}{% set page_title_suffix = ' | ' + title %}{#

  #}{% if page.type === "categories" and not page.title %}{#
    #}{{ __('title.category') + page_title_suffix }}{#
  #}{% elif page.type === "tags" and not page.title %}{#
    #}{{ __('title.tag') + page_title_suffix }}{#
  #}{% else %}{#
    #}{{ page.title + page_title_suffix }}{#
  #}{% endif %}{#
#}{% endblock %}

{% block page_class %}page-post-detail{% endblock %}

{% block content %}

  <div id="posts" class="posts-expand">
    {##################}
    {### PAGE BLOCK ###}
    {##################}
    <div class="post-block page">
      {% include '_partials/page-header.swig' %}
      {#################}
      {### PAGE BODY ###}
      {#################}
      <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if page.direction && page.direction.toLowerCase() === 'rtl' %} rtl{% endif %}">
        {{ page.content }}
        <ul id="awesomes-tabs">
          {% for x in [{text:'热门',sort:"hot",icon:"fire"},{text:'趋势',sort:"trend",icon:"line-chart"}] %}
            <li id="{{x.sort}}">
            <a href="{{ url_for(theme.menu.top100).split('||')[0] | trim }}?sort={{x.sort}}">
            <i class="fa fa-{{x.icon}}" aria-hidden="true"></i>
            {{x.text}}
            </a>
            </li>
          {% endfor %}
        </ul>
        <ul id="awesomes-content" c style="padding:0">
          {% for x in [1,2,3,4,5,6,7,8,9,10] %}
            {% include '_custom/skeleton.swig' %}
            <div class="divider"></div>
          {% endfor %}
        </ul>
      </div>
      {#####################}
      {### END PAGE BODY ###}
      {#####################}
    </div>
    {% include '_partials/breadcrumb.swig' %}
    {######################}
    {### END PAGE BLOCK ###}
    {######################}
  </div>

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}

{% block script_extra %}
  {% include '_scripts/pages/post-details.swig' %}
  <script>
    $(document).ready(function() {
      function getQueryString(key){
        var reg = new RegExp("(^|&)"+ key +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(!!r){
            return  unescape(r[2]);
        }
        return null;
      }
      function getTop100 (sort,success,fail) {
        $.ajax({
          url: "https://api.awesomes.cn/repo/top100",
          data: {
            sort: sort,
          },
          timeout: 1000 * 60,
          success: function(data){
            success && success(data)
          },
          error: function(error){
            fail && fail(error)
          }
        })
      }
      var awesomesTabs = $("#awesomes-tabs li")
      var sort = getQueryString('sort') || 'hot'
      awesomesTabs.each(function(){
        $(this).removeClass('active')
      })
      $("#"+sort).addClass('active')
      function renderContent (data) {
        var top100Content = $('#awesomes-content')
        top100Content.html('')
        for(var i in data) {
          var item = data[i]
          var li = document.createElement('li')
          var link = document.createElement('a')
          var scord = document.createElement('h3')
          var cover = document.createElement('img')
          var content = document.createElement('div')
          var contentTitle = document.createElement('p')
          var contentDesc= document.createElement('p')
          $(scord).addClass('scord').text(i*1+1)
          $(cover).attr({
            src: "https://awesomes.oss-cn-beijing.aliyuncs.com/repo/" + item.cover + "?x-oss-process=style/subject_repo",
            title: item.name,
          }).addClass('cover')
          $(contentTitle).addClass('title').text(item.name)
          $(contentDesc).addClass('desc').text(item.description_cn)
          $(content).addClass('content').append(contentTitle,contentDesc)
          $(link).attr({
            target: "_blank",
            href:"https://github.com/" + item.owner + '/' + item.name
          }).append(scord,cover,content)
          $(li).addClass('awesomes-li').hide().append(link)
          top100Content.append(li);
        }

          var postMotionOptions = window.postMotionOptions || {
            stagger: 100,
            drag   : true
          };
          top100Content.find('.awesomes-li').each(function(idx){
            $(this).velocity('transition.' + CONFIG.motion.transition.post_header, postMotionOptions);
          })
        ga && ga('send', 'pageview')
      }
      getTop100(sort, renderContent)
    })
  </script>
{% endblock %}
