$ = @$ or window?.$ or (try require?('jquery'))
{extendOnClass} = require('extendonclass')

class View
	@extend: extendOnClass

	events: null
	elements: null
	binds: null

	el: null
	$el: null

	constructor: (opts) ->
		# Dereference
		@events = if @events then (JSON.parse JSON.stringify @events) else {}
		@elements = if @elements then (JSON.parse JSON.stringify @elements) else {}
		@binds = @binds.slice()

		# Apply
		@setConfig(opts)

		# Refresh
		@refreshBinds()
		@refreshElement()
		@refreshElements()
		@refreshEvents()

	setConfig: (opts={}) ->
		for own key,value of opts
			@[key] = value
		@

	$: (selector) ->
		return @[selector] ? $(selector, @$el)

	refreshBinds: ->
		for methodName in @binds
			if @[methodName].toString().indexOf('[native code]') is -1
				@[methodName] = @[methodName].bind(@)
		@

	refreshElement: (el=null) ->
		@el = el ? @el
		@$el = $(@el)
		@el = @$el.get(0)
		@

	refreshElements: ->
		for own selector,elementName of @elements
			@[elementName] = $(selector, @$el)
		@

	refreshEvents: (opts={}) ->
		opts.detach = true
		opts.attach = true

		for own key,value of @events
			split = key.indexOf(' ')
			eventName = key.substr 0, split
			selector = key.substr split+1
			eventMethod = @[value]

			# use live events
			@$el.off(eventName, selector, eventMethod)  if opts.detach is true
			@$el.on(eventName, selector, eventMethod)   if opts.attach is true
		@

	destroy: ->
		@refreshEvents(attach: false)
		@$el.remove()
		@

module.exports = {View}