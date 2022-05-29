module OE
  #--------------------------------------------------------------------------
  # * Load Texture in resources/titles
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.title(filename)
    LoadTexture("Client/resources/titles/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Texture in resources/pictures
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.picture(filename)
    LoadTexture("Client/resources/pictures/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Texture in resources/gui
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.gui(filename)
    LoadTexture("Client/resources/gui/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Texture in resources/system/
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.system(filename)
    LoadTexture("Client/resources/system/#{filename}.png")
  end
  #--------------------------------------------------------------------------
  # * Load Music in resources/audio/music
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.music(filename)
    LoadMusicStream("Client/resources/audio/music/#{filename}.ogg")
  end
  #--------------------------------------------------------------------------
  # * Load Sound in resources/audio/sounds
  #     filename : nome do arquivo
  #--------------------------------------------------------------------------
  def self.sound(filename)
    LoadSound("Client/resources/audio/sounds/#{filename}.wav")
  end
end
