module StaticHelper

  def gmaps_options(marker_data)
    {
      "markers" => {"data" => marker_data},
      "map_options" => {"center_latitude" => 10, "center_longitude" => 0, "zoom" => 3, "auto_adjust" => false}
    }
  end
end
