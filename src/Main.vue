<template lang="pug">
#main
  //- autocomplete属性を使うためにはname属性が必要かな
  .container
    #cf7-controls
      div(style="display:flex;flex-flow:row;")
        TextControl.control-namae(
          style="flex:1 1 40%; margin-right: 2rem;"
          label="名前"
          :value.sync="attrs.namae"
          :error="errors.namae"
          :controlAttrs="{id:'control-namae', name:'full_name', autocomplete:'name'}"
        )
        TextControl.control-furigana(
          style="flex:1 1 60%"
          label="ふりがな"
          :value.sync="attrs.furigana"
          :error="errors.furigana"
          :controlAttrs="{id:'furigana'}"
        )
      TextControl.control-email(
        label="メールアドレス"
        :value.sync="attrs.email"
        :error="errors.email"
        :controlAttrs="{type:'email', id:'control-email', name:'email', autocomplete:'email'}"
      )
      TextControl.control-tel(
        label="電話番号"
        :value.sync="attrs.tel"
        :error="errors.tel"
        :controlAttrs="{type:'tel', id:'control-tel', name:'tel', autocomplete:'tel'}"
      )
      TextControl.control-yuubin(
        label="郵便番号"
        :value.sync="attrs.yuubin"
        :error="errors.yuubin"
        :controlAttrs="{id:'control-yuubin', name:'postal-code', autocomplete:'postal-code'}"
      )
      TextControl.control-address(
        label="住所"
        :value.sync="attrs.address"
        :error="errors.address"
        :controlAttrs="{id:'control-address', name:'address'}"
      )
      TextControl.control-subject(
        label="タイトル"
        :value.sync="attrs.subject"
        :error="errors.subject"
        :controlAttrs="{id:'control-subject', name:'subject'}"
      )
      TextAreaControl.control-message(
        label="メッセージ"
        :value.sync="attrs.message"
        :error="errors.message"
        :controlAttrs="{id:'control-message', name:'message'}"
      )
      input(type="submit" value="submit"  @click="send")
</template>
<style lang="scss">
  .container{width: 70vw;margin: 5rem auto;}
  .error{color: red;font-size: 80%;}
  #cf7-controls{
    font-size: 0.8rem;
    font-family: (ヒラギノ角ゴ ProN, Hiragino Kaku Gothic ProN, メイリオ, Meiryo, ＭＳ Ｐゴシック, Helvetica Neue, Helvetica, Arial, Roboto, Droid Sans, sans-serif),;
    display: flex;
    flex-flow: column nowrap;
    input{
      border: 0;
      border-bottom: 1px dotted black;
    }
    >*{
      &:not(:last-of-type){margin-bottom: 1.5rem;}
    }
    .control{
      display: flex;
      flex-flow: row nowrap;
      align-items: baseline;
      > :last-child{
        margin-left: 1rem;
        flex: auto;
        display: inline-flex;
        flex-flow: column;
        >:first-child{flex:auto;}
      }
    }
  }
</style>
<script lang="coffee">
  import checkers from "./checkers"
  import {TextControl, TextAreaControl} from "./Control"

  export default
    components: {TextControl, TextAreaControl}
    data: ->attrs: namae: "", furigana: "", email: "", tel: "", yuubin: "", address: "", subject: "", message: ""
    computed:
      ready: ->_.every @errors, (item)->not item?
      errors: ->_.mapObject @attrs, (val, attr)->checkers[attr](val) ? '&nbsp;'
    methods:
      send: -> do($=jQuery)=>
        # $("#cf7-namae").val @namae
        # $("#cf7-email").val @email
        # $(".wpcf7-submit").click()
    # mounted: ->
    #   jQuery(".wpcf7").on "wpcf7invalid", (e)->
    #     console.log e.detail
</script>
