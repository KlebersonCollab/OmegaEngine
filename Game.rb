require_relative "util/setup_dll"

require_relative "src/modules/OE"

require_relative "src/scenes/SceneManager"
require_relative "src/scenes/SceneBase"
require_relative "src/scenes/SceneTitle"
require_relative "src/scenes/SceneDois"

require_relative "src/gui/Emitter"
require_relative "src/gui/Button"

# Width, Height, Title, FPS
SceneManager.run(1360, 768, "Omega Engine", 120)
