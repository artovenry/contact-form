InputControl=
  inheritAttrs: off
  props: ["value", "error", "label", "inputAttrs"]
  data: ->
    tainted: no
    showError: no
  render: ($)->
    label= $ "label",{attrs: for: @inputAttrs.id}, (@label ? '')
    input= $ "input",
      attrs: _.defaults @inputAttrs, type: "text"
      domProps: value: @value
      on:
        input: (e)=>
          @tainted= yes; Object.freeze(@tainted)
          @$emit "update:value", e.target.value
          @showError= no
        blur: (e)=>
          @showError= yes if @error? and @tainted
    error= $ "div",
      class: 'control-error'
      style: display: if @showError then 'block' else 'none'
      domProps: innerHTML: @error
    $ "div", [label, input, error]


export TextControl=
