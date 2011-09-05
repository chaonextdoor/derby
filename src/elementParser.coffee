module.exports = (view, events) ->
  
  elementPlaceholder:
    input: (attr, attrs, name) ->
      return 'attr'  unless attr == 'value'
      if 'silent' of attrs
        delete attrs.silent
        method = 'prop'
        silent = 1
      else
        # Update the property unless the element has focus
        method = 'propPolite'
        silent = 0
      events.push (data, modelEvents, domEvents) ->
        domArgs = ['set', data[name].model, attrs._id || attrs.id, 'prop', 'value', silent]
        domEvents.bind 'keyup', domArgs
        domEvents.bind 'keydown', domArgs
      return method

  elementBind:
    a: (attrs, name) ->
      if name is 'click'
        attrs.href = '#'  unless attrs.href
        attrs.onclick = 'return false'  unless attrs.onclick
    form: (attrs, name) ->
      if name is 'submit'
        attrs.onsubmit = 'return false'  unless attrs.onsubmit
