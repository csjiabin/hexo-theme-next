var gulp = require("gulp");
var minifycss = require("gulp-minify-css");
var uglify = require("gulp-uglify-es").default;
var htmlmin = require("gulp-htmlmin");
var htmlclean = require("gulp-htmlclean");
var imagemin = require("gulp-imagemin");
var pump = require("pump");
// 压缩html
gulp.task("minify-html", function () {
  return gulp
    .src("./public/**/*.html")
    .pipe(htmlclean())
    .pipe(
      htmlmin({
        removeComments: true,
        minifyJS: true,
        minifyCSS: true,
        minifyURLs: true,
      })
    )
    .pipe(gulp.dest("./public"));
});
// 压缩css
gulp.task("minify-css", function () {
  return gulp
    .src("./public/**/*.css")
    .pipe(
      minifycss({
        compatibility: "ie8",
      })
    )
    .pipe(gulp.dest("./public"));
});
// 压缩js
gulp.task("minify-js", function () {
  // pump([gulp.src("lib/*.js"), uglify(), gulp.dest("dist")], cb);
  return gulp
    .src("./public/js/**/*.js")
    .pipe(uglify())
    .pipe(gulp.dest("./public"));
});
// 压缩图片
gulp.task("minify-images", function () {
  return gulp
    .src("./public/images/**/*.{png,jpg,gif,ico}")
    .pipe(
      imagemin(
        [
          imagemin.gifsicle({ optimizationLevel: 3 }),
          imagemin.mozjpeg({ progressive: true }),
          imagemin.optipng({ optimizationLevel: 7 }),
          imagemin.svgo(),
        ],
        { verbose: true }
      )
    )
    .pipe(gulp.dest("./public/images"));
});
// 压缩图片
gulp.task("minify-images-uploads", function () {
  return gulp
    .src("./public/uploads/**/*.{png,jpg,gif,ico}")
    .pipe(
      imagemin(
        [
          imagemin.gifsicle({ optimizationLevel: 3 }),
          imagemin.mozjpeg({ progressive: true }),
          imagemin.optipng({ optimizationLevel: 7 }),
          imagemin.svgo(),
        ],
        { verbose: true }
      )
    )
    .pipe(gulp.dest("./public/uploads"));
});
// 默认任务
gulp.task(
  "default",
  gulp.parallel([
    "minify-html",
    "minify-css",
    "minify-js",
    "minify-images",
    "minify-images-uploads",
  ])
);
