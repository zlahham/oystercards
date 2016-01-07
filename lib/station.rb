class Station
  attr_reader :name, :zone

  STATIONS = {
    Victoria:       1,
    Euston:         1,
    Aldgate:        1,
    Holborn:        1,
    Archway:        2,
    Whitechapel:    2,
    Mile_end:       2,
    West_ham:       3,
    Barking:        4,
    Dagenham_east:  5,
    Upminster:      6,
    Uxbridge:       6
  }

  def initialize(name)
    @name = name
    @zone = STATIONS[name]
  end

end
