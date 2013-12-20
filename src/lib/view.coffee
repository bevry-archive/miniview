# Import
$ = @$ or window?.$ or (try require?('jquery'))
{extendOnClass} = require('extendonclass')

# Define
class View
	@extend: extendOnClass

	events: null
	elements: null

	el: null
	$el: null

	constructor: (opts) ->
		# Dereference
		@events = if @events then (JSON.parse JSON.stringify @events) else {}
		@elements = if @elements then (JSON.parse JSON.stringify @elements) else {}

		# Apply
		@setConfig(opts)

		# Refresh
		@refreshElement()
		@refreshElements()
		@refreshEvents()

		# Chain
		@

	setConfig: (opts={}) ->
		# Apply the configuration
		for own key,value of opts
			@[key] = value

		# Chain
		@

	refreshElement: (el=null) ->
		# Fallback
		@el = el ? @el

		# jQueryify
		@$el = $(@el)

		# de-jQueryify
		@el = @$el.get(0)

		# Chain
		@

	refreshElements: ->
		# Cycle elements
		for own selector,elementName of @elements
			# Attach the element to the view
			@[elementName] = $(selector, @$el)

		# Chain
		@

	refreshEvents: (opts={}) ->
		# Prepare
		opts.detach = true
		opts.attach = true

		# Cycle events
		for own key,methodName of @events
			# Bind events to the view
			if @[methodName].toString().indexOf('[native code]') is -1
				@[methodName] = @[methodName].bind(@)

			# Determine the event and the selector
			split = key.indexOf(' ')
			eventName = key.substr 0, split
			selector = key.substr split+1

			# Determine the method
			eventMethod = @[methodName]

			# Use live events for the listening
			@$el.off(eventName, selector, eventMethod)  if opts.detach is true
			@$el.on(eventName, selector, eventMethod)   if opts.attach is true

		# Chain
		@

	destroy: ->
		# Detatch events
		@refreshEvents(detach: true, attach: false)

		# Remove the element
		@$el.remove()

		# Chain
		@

# Export
module.exports = {View}