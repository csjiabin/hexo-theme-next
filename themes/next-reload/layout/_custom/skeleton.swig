<style>
  .skeleton{
    display: table;
    width: 100%;
    padding: 0 18px;
    box-sizing: border-box;
  }
  .skeleton-header{
    display: table-cell;
    vertical-align: middle;
    padding-right: 16px
  }
  .skeleton-header .skeleton-avatar{
    border-radius: 50%;
    width: 60px;
    height: 60px;
    line-height: 60px;
    display: inline-block;
    vertical-align: top;
  }
  .skeleton-content{
    display: table-cell;
    vertical-align: top;
    width: 100%;
  }
  .skeleton-content .skeleton-title{
    height:16px;
    width: 50%;
    margin:0;
    padding:0;
    padding-top:0 !important;
  }
  .skeleton-content .skeleton-title+.skeleton-paragraph{
    list-style:none;
    margin:0;
    margin-top:28px;
    padding:0;
  }
  .skeleton-content .skeleton-paragraph>li{
    height:16px;
    list-style: none !important;
    width: 100%
  }
  .skeleton-content .skeleton-paragraph>li+li {
    margin-top: 16px
  }
  .skeleton-header .skeleton-avatar,
  .skeleton-content .skeleton-title,
  .skeleton-content .skeleton-paragraph>li{
    background: -webkit-gradient(linear, left top, right top, color-stop(25%, #f2f2f2), color-stop(37%, #e6e6e6), color-stop(63%, #f2f2f2));
    background:-webkit-linear-gradient(left, #f2f2f2 25%, #e6e6e6 37%, #f2f2f2 63%);
    background:linear-gradient(90deg, #f2f2f2 25%, #e6e6e6 37%, #f2f2f2 63%);
    -webkit-animation:ant-skeleton-loading 1.4s ease infinite;
    animation:ant-skeleton-loading 1.4s ease infinite;
    background-size:400% 100%
  }

  @-webkit-keyframes ant-skeleton-loading{
    0%{
        background-position:100% 50%
      }
    100%{
      background-position:0 50%
    }
  }
  @keyframes ant-skeleton-loading{
    0%{
      background-position:100% 50%
    }
    100%{
      background-position:0 50%
    }
  }
</style>
<div class="skeleton">
  <div class="skeleton-header">
    <span class="skeleton-avatar"></span>
  </div>
  <div class="skeleton-content">
    <h3 class="skeleton-title"></h3>
    <ul class="skeleton-paragraph">
      <li></li>
      <li></li>
    </ul>
  </div>
</div>

