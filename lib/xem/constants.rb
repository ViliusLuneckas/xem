module Xem
  module Constants
    GL_HINTS = [
        GL_FOG_HINT,
        GL_FRAGMENT_SHADER_DERIVATIVE_HINT,
        GL_GENERATE_MIPMAP_HINT,
        GL_LINE_SMOOTH_HINT,
        GL_PERSPECTIVE_CORRECTION_HINT,
        GL_POINT_SMOOTH_HINT,
        GL_POLYGON_SMOOTH_HINT,
        GL_TEXTURE_COMPRESSION_HINT
    ]

    FOG_MODES = [
        GL_EXP,
        GL_EXP2,
        GL_LINEAR
    ]
    
    BOX = {
        :up =>
            [
                [1, 1, 0], [1, 1, 1], [0, 1, 1], [0, 1, 0]
            ],
        :down =>
            [
              [0, 0, 0], [1, 0, 0], [1, 0, 1], [0, 0, 1]
            ],
        :left =>
            [
                [0, 0, 0], [0, 1, 0], [0, 1, 1], [0, 0, 1]
            ],
        :right =>
            [
                [1, 0, 1], [1, 1, 1], [1, 1, 0], [1, 0, 0]
            ],
        :forward =>
            [
                [1, 0, 0], [1, 1, 0], [0, 1, 0], [0, 0, 0]
            ],
        :backward =>
            [
                [0, 0, 1], [0, 1, 1], [1, 1, 1], [1, 0, 1]
            ]
    }
    
    X_INTERVAL = 1/4.0
    Y_INTERVAL = 1/3.0
    SINGLE_BOX = [[X_INTERVAL, Y_INTERVAL], [X_INTERVAL, 0], [0, 0], [0, Y_INTERVAL]]
    SKY_BOX_TEXTURE_COORDS = {
      :up =>
          [
              *SINGLE_BOX.move(:right => 1)
          ],
      :down =>
          [
            [0.25, 0.6666666666666666], [0.5, 0.6666666666666666], [0.5, 1.0], [0.25, 1.0]
          ],
      :left =>
          [
              *SINGLE_BOX.move(:down => 1)
          ],
      :right =>
          [

              *SINGLE_BOX.move(:right => 2, :down => 1)
          ],
      :forward =>
          [
              *SINGLE_BOX.move(:right => 1, :down => 1)
          ],
      :backward =>
          [
              *SINGLE_BOX.move(:right => 3, :down => 1)
          ]
    }
  end
end
