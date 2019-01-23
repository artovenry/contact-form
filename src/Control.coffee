Control=
  props: ["tag", "attrs", "value"]
  render: (h)->
    switch @tag
      when 'input'
        attrs= _.defaults @attrs, type: 'text'
        style= """
          border: 0;
          border-bottom: 1px dotted black;
        """
      when 'textarea'
        attrs= @attrs
        style= """
          border: 1px dotted black;
        """
    h @tag, {attrs: attrs, style: style, domProps: {value: @value}, on: @$listeners}

BaseComponent=
  inheritAttrs: off
  controlTagName:null #<---control要素のタグ名になる
  props: ["value", "error", "label", "controlAttrs"]
  data: ->tainted: no, showError: no
  methods:
    input: (e)->
      @$emit "update:value", e.target.value
      @tainted= yes; Object.freeze @$tainted
      @showError= no
    blur: (e)->
      @showError= yes if @error? and @tainted
  render: (h)->
    <div class="control"
      style="
        display: flex;
        align-items: baseline;
      "
    >
      <label for={@controlAttrs.id}>
        {@label}
      </label>
      <span
        style="
          flex: auto;
          display: inline-flex;
          flex-flow: column;
          margin-left: 1rem;
        "
      >
        <Control tag={@$options.controlTagName}
          attrs={@controlAttrs} value={@value}
          onInput={@input} onBlur={@blur}
          style="flex:auto"
        />
        <span
          class="control-error"
          style={{visibility: if @showError then 'visible' else 'hidden'}}
          domPropsInnerHTML={@error ? '&nbsp;'}
        />
      </span>
    </div>


export TextControl= extends: BaseComponent, controlTagName: "input"
export TextAreaControl= extends: BaseComponent, controlTagName: "textarea"
