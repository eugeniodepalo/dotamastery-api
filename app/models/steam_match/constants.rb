class SteamMatch
  module Constants
    LANES_MAPPING = {
      'radiant' => {
        'bottom' => 'safelane',
        'middle' => 'middle',
        'top' => 'offlane',
        'radiant_jungle' => 'jungle',
        'dire_jungle' => 'enemy_jungle',
        'roaming' => 'roaming'
      },

      'dire' => {
        'bottom' => 'offlane',
        'middle' => 'middle',
        'top' => 'safelane',
        'radiant_jungle' => 'enemy_jungle',
        'dire_jungle' => 'jungle',
        'roaming' => 'roaming'
      }
    }

    REGIONS_MAPPING = {
      'us_west' => [111, 112, 113, 114],
      'us_east' => [121, 122, 123, 124],
      'europe' => [131, 132, 133, 134, 135, 136, 137, 138, 171, 172, 191, 193, 192],
      'japan' => [144, 145],
      'se_asia' => [142, 143, 151, 152, 153, 154, 155, 156],
      'dubai' => [161, 163],
      'russia' => [181, 182, 183, 184, 185, 186, 187, 188],
      'south_america' => [200, 201, 202, 203, 204, 241, 242, 251],
      'south_africa' => [211, 212, 213],
      'china' => [221, 222, 223, 224, 225, 227, 231, 232],
      'india' => [261]
    }
  end
end
