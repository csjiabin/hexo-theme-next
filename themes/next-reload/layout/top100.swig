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
        <ul>
          {% for x in [{text:'热门',sort:"hot"},{text:'趋势',sort:"trend"}] %}
            <li><a href="{{ url_for(theme.menu.top100).split('||')[0] | trim }}?sort={{x.sort}}">{{x.text}}</a></li>
          {% endfor %}
        </ul>
        <div class="tab-panels">
          <ul class="tab-content" id="top100-content" style="padding:0">
            {% for x in [1,2,3,4,5,6,7,8,9,10] %}
              {% include '_custom/skeleton.swig' %}
              <div class="divider"></div>
            {% endfor %}
          </ul>
        </div>
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
    function getQueryString(key){
      var reg = new RegExp("(^|&)"+ key +"=([^&]*)(&|$)");
      var r = window.location.search.substr(1).match(reg);
      if(!!r){
          return  unescape(r[2]);
      }
      return null;
    }
    function getTop100(sort,success,fail){
      $.ajax({
        url:"https://api.awesomes.cn/repo/top100",
        data: { sort: sort },
        success: function(data){
          success && success(data)
        },
        error: function(error){
          fail && fail(error)
        }
      })
    }
    var top100Content = $('#top100-content')
    function renderContent(data){
      top100Content.html('')
      for(var i in data) {
        var item = data[i]
        var li = document.createElement('li')
        var link = document.createElement('a')
        var scord = document.createElement('span')
        var coverContent = document.createElement('div')
        var cover = document.createElement('img')
        var descContent = document.createElement('div')
        var descTitle = document.createElement('p')
        var descWrap = document.createElement('p')
        $(scord).addClass('scord').text(i*1+1)
        $(cover).attr({
          src: "https://awesomes.oss-cn-beijing.aliyuncs.com/repo/" + item.cover + "?x-oss-process=style/subject_repo",
          title: item.name,
          width: 60
        })
        $(coverContent).addClass('cover').append(cover)
        $(descTitle).addClass('title').text(item.name)
        $(descWrap).text(item.description_cn)
        $(descContent).addClass('desc').append(descTitle,descWrap)
        $(link).attr({
          target: "_blank",
          href:"https://github.com/" + item.owner + '/' + item.name
        }).append(scord,coverContent,descContent)
        $(li).append(link)
        top100Content.append(link);
      }
      ga && ga('send', 'pageview')
    }
    if (getQueryString('sort')==='trend') {
      getTop100("trend", renderContent)
    } else {
      getTop100("hot",renderContent)
    }
  </script>
{% endblock %}
