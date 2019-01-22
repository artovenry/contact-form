render= ($, control)->
  label= $ "label",{attrs: for: @controlAttrs.id}, (@label ? '')
  error= $ "span",
    class: 'control-error'
    style: visibility: if @showError then 'visible' else 'hidden'
    domProps: innerHTML: @error
  # $ "div", {class: 'control'},[
  #   $ "div", [label, control]
  #   error
  # ]
  $ "div", {class: 'control'},[
    label
    $ "span", [control, error]
  ]

onInput= (e)->
  @tainted= yes; Object.freeze(@tainted)
  @$emit "update:value", e.target.value
  @showError= no
onBlur= (e)->
  @showError= yes if @error? and @tainted

Base=
  inheritAttrs: off
  props: ["value", "error", "label", "controlAttrs"]
  data: ->tainted: no, showError: no

export TextControl=
  extends: Base
  render: ($)->
    control= $ "input",
      attrs: _.defaults @controlAttrs, type: "text"
      domProps: value: @value
      on: input: _.bind(onInput, @), blur: _.bind(onBlur, @)
    render.call @, $, control

export TextAreaControl=
  extends: Base
  render: ($)->
    control= $ "textarea",
      attrs: @controlAttrs
      domProps: value: @value
      on: input: _.bind(onInput, @), blur: _.bind(onBlur, @)
    render.call @, $, control
