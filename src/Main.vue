<template lang="pug">
#main
  //- autocomplete属性を使うためにはname属性が必要かな
  .container
    TextControl#text-control-namae(
      label="名前"
      :value.sync="attrs.namae"
      :error="errorFor('namae')"
      :controlAttrs="{id:'control-namae', name:'full_name', autocomplete:'name'}"
    )
    TextControl#text-control-furigana(
      label="ふりがな"
      :value.sync="attrs.furigana"
      :error="errorFor('furigana')"
      :controlAttrs="{id:'furigana'}"
    )
    TextControl#text-control-email(
      label="メールアドレス"
      :value.sync="attrs.email"
      :error="errorFor('email')"
      :controlAttrs="{type:'email', id:'control-email', name:'email', autocomplete:'email'}"
    )
    TextControl#text-control-tel(
      label="電話番号"
      :value.sync="attrs.tel"
      :error="errorFor('tel')"
      :controlAttrs="{type:'tel', id:'control-tel', name:'tel', autocomplete:'tel'}"
    )
    TextControl#text-control-yuubin(
      label="郵便番号"
      :value.sync="attrs.yuubin"
      :error="errorFor('yuubin')"
      :controlAttrs="{id:'control-yuubin', name:'postal-code', autocomplete:'postal-code'}"
    )
    TextControl#text-control-address(
      label="住所"
      :value.sync="attrs.address"
      :error="errorFor('address')"
      :controlAttrs="{id:'control-address', name:'address'}"
    )
    TextControl#text-control-subject(
      label="タイトル"
      :value.sync="attrs.subject"
      :error="errorFor('subject')"
      :controlAttrs="{id:'control-subject', name:'subject'}"
    )
    TextAreaControl#textarea-control-message(
      label="メッセージ"
      :value.sync="attrs.message"
      :error="errorFor('message')"
      :controlAttrs="{id:'control-message', name:'message'}"
    )

     input(type="submit" value="submit"   :disabled="!ready"  @click="send")
</template>
<style lang="scss" scoped>
  .container{width: 80vw;margin: 1rem auto;}
  .error{color: red;font-size: 80%;}
</style>
<script lang="coffee">
  import checkers from "./checkers"
  import {TextControl, TextAreaControl} from "./InputControl"

  # attrs=
  #   namae: "", furigana: "", email: "", tel: "", yuubin: "", address: "", subject: "", message: ""
  # errors= _.mapObject attrs, (item)->""
  # tainted= _.mapObject attrs, (item)->no

  # watcher= _.inject _.keys(attrs), (memo, key)->
  #   _.extend memo,"attrs.#{key}": {immediate: on, handler: (val)->@errors[key]= checkers[key](val) ? ''}
  # , {}
  export default
    # data: ->{attrs, errors, tainted}
    components: {TextControl}
    data: ->attrs: namae: "", furigana: ""
    computed:
      ready: ->_.every _.keys(@attrs), (key)=>@errorFor(key)?
    methods:
      errorFor: (attr)->checkers[attr](@$data.attrs[attr])
      send: -> do($=jQuery)=>
        # $("#cf7-namae").val @namae
        # $("#cf7-email").val @email
        # $(".wpcf7-submit").click()
    # mounted: ->
    #   jQuery(".wpcf7").on "wpcf7invalid", (e)->
    #     console.log e.detail
</script>
