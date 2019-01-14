{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}

{% block title %}{{ __('title.top100') }} | {{ title }}{% endblock %}

{% block page_class %}page-archive{% endblock %}

{% block content %}
  {#####################}
  {### ARCHIVE BLOCK ###}
  {#####################}
  <div class="post-block page">
  <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if page.direction && page.direction.toLowerCase() === 'rtl' %} rtl{% endif %}">
        <div class="tabs">
          <ul class="nav-tabs">
            <li class="tab active"><a href="#hot">排行</a></li>
            <li class="tab"><a href="trend">趋势</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active">
              <ul>
              </ul>
            </div>
            <div class="tab-pane">
            <p>2</p>
            </div>
          </div>
        </div>
      </div>
    <div id="posts" class="posts-collapse">
    <span class="archive-page-counter">
    排行
    </span>

      <span class="archive-move-on"></span>
      {% for post in page.posts %}

        {# Show year #}
        {% set year %}
        {% set post.year = date(post.date, 'YYYY') %}

        {% if post.year !== year %}
          {% set year = post.year %}
          <div class="collection-title">
            <{% if theme.seo %}h2{% else %}h1{% endif %} class="archive-year" id="archive-year-{{ year }}">{{ year }}</{% if theme.seo %}h2{% else %}h1{% endif %}>
          </div>
        {% endif %}
        <div class="collection-title" style="opacity: 1; display: block; transform: translateX(0px);">
            <h2 class="archive-year" id="archive-year-2018" style="opacity: 1; display: block; transform: translateX(0px);">2018</h2>
          </div>
        <article class="post post-type-normal" itemscope="" itemtype="http://schema.org/Article">
          <header class="post-header" style="opacity: 1; display: block; transform: translateY(0px);">
            <h3 class="post-title">
              <a class="post-title-link" href="/2018/11/18/JS中的内存管理/" itemprop="url">
                <span itemprop="name">JS中的内存管理</span>
              </a>
            </h3>
            <div class="post-meta">
              <time class="post-time" itemprop="dateCreated" datetime="2018-11-18T18:41:32+08:00" content="2018-11-18">
                11-18
              </time>
            </div>
          </header>
        </article>
        {# endshow #}
      {% endfor %}
    </div>
  </div>
  {#########################}
  {### END ARCHIVE BLOCK ###}
  {#########################}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}

{% block script_extra %}
<script>
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
getTop100("hot",function(data){
  console.log('hot:',data)
})
getTop100("trend",function(data){
  console.log('trend:',data)
})

</script>
{% endblock %}
