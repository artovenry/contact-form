<template lang="pug">
  form(novalidate)
    field(v-bind.sync="contact.name" autocomplete="name")
      header(slot="header") 名前
    field(v-bind.sync="contact.kana")
      header(slot="header") ふりがな
    field(v-bind.sync="contact.email" type="email" autocomplete="email")
      header(slot="header") email
    field(v-bind.sync="contact.tel" type="tel" autocomplete="tel")
      header(slot="header") 電話番号
    field(v-bind.sync="contact.message")
      template(slot="control" scope="c")
        textarea(
          :value="c.value"
          @input="c.input($event.target.value)"
          @blur ="c.input($event.target.value)"
        )
      header(slot="header") メッセージ
    fieldset
      input(type="button" value="send" @click="submit")
</template>


<script lang="coffee">
  import Field from "./Field.vue"
  validators=  require "./validators.coffee"

  export default
    components: field: Field
    data: ->
      contact_attrs= "name kana email tel message".split " "
      contact: _.object contact_attrs, contact_attrs.map (attr)->
        value: "", errors: [], notifying: no
    computed:
      isValid: ->_.chain(@contact).pluck("errors").every(_.isEmpty).value()

    methods:
      submit: ->
        item.notifying= yes for key, item of @contact
        if @isValid
          console.log _.mapObject @contact, (item)->item.value

    created: ->
      _.each validators, (validator, attr)=>
        @$watch "contact.#{attr}.value", (value)->
          @contact[attr].errors= _.compact(validator(value))
        , immediate: yes
</script>

<style lang="sass">
</style>
