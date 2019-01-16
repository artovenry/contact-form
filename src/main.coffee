import Main from "./Main.vue"
jQuery ->
  new Vue
    el: "#v-app"
    render: (h)->h Main
