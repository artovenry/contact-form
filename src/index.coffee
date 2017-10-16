import Vue from "vue/dist/vue.esm.js"
import Form from "./Form.vue"

# DEV
if process.env.NODE_ENV is "development"
  Form


    created: ->
      console.log process.env
        @contact[attr]= value for attr, value of contact=
          name: "sample name"
          kana: "さんぷるねーむ"
          email: "sample@hogehoge.com"
          message: """
            hogehoge
            hogehogehogehoge
          """
    components:
      field: Field


vm= new Vue
  render: (h)->h(Form)
document.addEventListener "DOMContentLoaded", (->vm.$mount("#site"))
