path= require "path"
_ = require "underscore"
webpack= require "webpack"
Autoprefixer         = require "autoprefixer"
MiniCssExtractPlugin = require "mini-css-extract-plugin"
VueLoaderPlugin      = require "vue-loader/lib/plugin"
HtmlWebpackPlugin    = require "html-webpack-plugin"
host= process.env.npm_config_host ? "localhost"
port = process.env.npm_config_port ? "8080"

module.exports=
  resolve:
    modules: [path.resolve("src"), "node_modules"]
    extensions: [".js", ".coffee", ".json"]
  entry:
    style:["main.scss"]
    script:["main.coffee"]
  output:
    filename: "[name].js"
    chunkFilename: "[id].chunk.js"
    path: path.resolve("__bundled__")
    publicPath: "http://#{host}:#{port}/"
  mode: "development"
  devtool: "inline-source-map"
  devServer:
    host: host, port: port
    headers:
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, PATCH, OPTIONS",
      "Access-Control-Allow-Headers": "X-Requested-With, content-type, Authorization"
  module:
    rules: do ->
      cssLoaders= (opts={vue: no, indented: no})->
        _.compact _.values
          STYLE:
            loader: if opts.vue then "vue-style-loader" else "style-loader"
          Css:
            loader: "css-loader"
            options: sourceMap: on
          PostCss:
            loader: "postcss-loader"
            options:
              sourceMap: on
              plugins:[Autoprefixer]
          Sass:
            loader: "sass-loader"
            options:
              includePaths: [path.resolve("src/sass")]
              indentedSyntax: opts.indented
              sourceMap: on
      babelLoader=  loader: "babel-loader", options: presets: ["@babel/env"]
      _.values
        JS:
          test: /\.js$/, use: [babelLoader], exclude: /node_modules/
        COFFEE:
          test: /\.coffee$/, use: [babelLoader, {loader: "coffee-loader"}]
        Pug:
          test: /\.pug$/
          oneOf: [
            {resourceQuery: /^\?vue/, use: ["pug-plain-loader"]}
            {use: ["pug-loader"]}
          ]
        VUE:
          test: /\.vue$/, loader: "vue-loader"
        YAML:
          test: /\.y(a)?ml$/, loader: "json-loader!yaml-loader"
        Css:
          test: /\.css$/
          oneOf: [
            {resourceQuery: /^\?vue/, use: cssLoaders(vue: yes)}
            {use: cssLoaders()}
          ]
        Sass:
          test: /\.sass$/
          oneOf: [
            {resourceQuery: /^\?vue/, use: cssLoaders(vue: yes, indented: yes)}
            {use: cssLoaders(indented: yes)}
          ]
        Scss:
          test: /\.scss$/
          oneOf: [
            {resourceQuery: /^\?vue/, use: cssLoaders(vue: yes, indented: no)}
            {use: cssLoaders(indented: no)}
          ]
        Media:
          test: /\.(png|jpe?g|gif|svg)$/i , loader: "url-loader", options: limit: 10000 , name: "[name].[ext]"
  plugins: _.compact _.flatten _.values
    Provide: new webpack.ProvidePlugin
      _     : "underscore"
    Define:
      new webpack.DefinePlugin
        NODE_HOST:  JSON.stringify(host)
        NODE_PORT:  JSON.stringify(port)
    VUE: new VueLoaderPlugin
    HWP: [
      new HtmlWebpackPlugin template: "src/assets.php.ejs", inject: off, filename: "assets.php"
      new HtmlWebpackPlugin template: "src/design.pug", inject: off, filename: "design.html", host: host, port: port
    ]
