<template lang="pug">
  form(novalidate)
    field(v-bind.sync="contact.name")
      header(slot="header") 名前
    field(v-bind.sync="contact.kana")
      header(slot="header") ふりがな
    fieldset
      input(type="button" value="send" @click="submit")
</template>


<script lang="coffee">
  import Field from "./Field.vue"
  validators= 
    name: (value)->[
      if value is "" then "必須入力です"
    ]
    kana: (value)->[
      if value is "" then "必須入力です"
      else if not /^[\u3041-\u3096][\u3041-\u3096\u3000\u30FB-\u30FE]+$/.test value then  "全角ひらがなで記入してください"
    ]
    email: (value)->[
      if value is "" then "必須入力です"
      else if not emailValidator.validate value then "メールアドレスの形式が無効です"
    ]
    tel: (value)->[
      if value isnt  "" and not /[\d\-\+\(\)]+$/.test value
        "電話番号は半角数字<b>「0〜9」</b>と<b>ハイフン「-」</b>,<b>括弧「()」</b>,<b>プラス「+」</b>のみ使用可能です"
    ]
    message: (value)->[
      if value is "" then "必須入力です"
    ]

  export default
    components: field: Field
    data: ->
      contact= name: {value: ""}, kana: {value: ""}, email: {value: ""}, tel: {value: ""}, message: {value: ""}
      contact: _.mapObject contact, (item)->_.extend item,
        errors: [], notifying: no

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
          @contact[attr].errors.splice 0
          Array::push.apply @contact[attr].errors, _.compact(validator(value))
        , immediate: yes
</script>

<style lang="sass">
</style>
