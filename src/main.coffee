import Main from "./Main.vue"
$= jQuery
$ ->
  $(".wpcf7").on "wpcf7invalid", (e)->
    console.log e.detail
  new Vue
    el: "#v-app"
    render: (h)->h Main
