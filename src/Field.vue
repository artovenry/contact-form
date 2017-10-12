<template lang="pug">
  .field(:class="{invalid: notify}")
    slot(name="header")
    slot(name="control" :change="change" :disabled="disabled")
      input(
        :type="type"
        :value="value"
        @keydown="change($event.target.value)"
        @blur="change($event.target.value)"
        :disabled.prop="disabled"
        :autocomplete="autocomplete"
      )
      ul(v-show="notify")
        slot(name="message" :errors="errors")
          li(v-html="item" v-for="item in errors")
</template>
<script lang="coffee">
  export default
    props:
      attr         : default: ""
      value        : default: ""
      type         : default: "text"
      autocomplete : default: "off"
    data: ->state: off, disabled: off
    computed:
      notify: ->@state && @errors.length
      errors : ->
        validator= @$parent.validators[@attr]
        errors= _.compact validator(@value)
        validator.status= _.isEmpty errors
        errors
    methods:
      clear: ->
        @state= off; @$emit "input", ""
      change: (value)->
        @$emit "input", value
        @state= off
</script>
<style lang="scss" scoped>
  .v-enter-active, .v-leave-active{transition: all 1s}
  .v-enter, .v-leave-to{opacity: 0}
  .invalid{input, textarea{
      &:not(:focus){border: 1px solid red;}
  }}
</style>
