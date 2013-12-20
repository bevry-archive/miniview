# History

- v1.2.0 December 20, 2013
	- Removed `binds` option

- v1.1.1 December 20, 2013
	- Fixed instantiation without `binds` being set (regression since v1.0.2)

- v1.1.0 December 20, 2013
	- Events are now always bound to the view
	- Removed the `View::$` method

- v1.0.2 December 20, 2013
	- Fixed v1.0.2

- v1.0.2 December 20, 2013
	- Added `binds` option
	- Dereference `binds`, `elements`, and `events`
	- Renamed `opts.bind` to `opts.attach` in `refreshElements`

- v1.0.1 December 20, 2013
	- Now ignores bundling the jQuery dependency via the [`browser` field](https://gist.github.com/defunctzombie/4339901)
	- Non-CoffeeScript users can now use `require('miniview').View.extend({})` to extend the Pointer Class

- v1.0.0 December 4, 2013
	- Initial working release
