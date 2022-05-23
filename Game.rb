require_relative 'util/setup_dll'

require_relative 'scripts/modules/Cache'

require_relative 'scripts/scenes/SceneManager'
require_relative 'scripts/scenes/SceneBase'
require_relative 'scripts/scenes/SceneTitle'
require_relative 'scripts/scenes/SceneDois'


SceneManager.run(1360,768,"Omega Engine",120)
