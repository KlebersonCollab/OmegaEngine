module OE
  #--------------------------------------------------------------------------
  # * Load Texture in resources/titles
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.title(filename)
    LoadTexture("resources/titles/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Texture in resources/pictures
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.picture(filename)
    LoadTexture("resources/pictures/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Texture in resources/gui
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.gui(filename)
    LoadTexture("resources/gui/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Music in resources/audio/music
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.music(filename)
    LoadMusicStream("resources/audio/music/#{filename}.ogg")
  end
  #--------------------------------------------------------------------------
  # * Load Sound in resources/audio/sounds
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.sound(filename)
    LoadSound("resources/audio/sounds/#{filename}.ogg")
  end
end
