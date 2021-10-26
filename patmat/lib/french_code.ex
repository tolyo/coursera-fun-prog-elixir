defmodule FrenchCode do
  def get() do
    Fork.new(
      Fork.new(
        Fork.new(
          Leaf.new('s', 121_895),
          Fork.new(
            Leaf.new('d', 56269),
            Fork.new(
              Fork.new(
                Fork.new(Leaf.new('x', 5928), Leaf.new('j', 8351), ['x', 'j'], 14279),
                Leaf.new('f', 16351),
                ['x', 'j', 'f'],
                30630
              ),
              Fork.new(
                Fork.new(
                  Fork.new(
                    Fork.new(
                      Leaf.new('z', 2093),
                      Fork.new(Leaf.new('k', 745), Leaf.new('w', 1747), ['k', 'w'], 2492),
                      ['z', 'k', 'w'],
                      4585
                    ),
                    Leaf.new('y', 4725),
                    ['z', 'k', 'w', 'y'],
                    9310
                  ),
                  Leaf.new('h', 11298),
                  ['z', 'k', 'w', 'y', 'h'],
                  20608
                ),
                Leaf.new('q', 20889),
                ['z', 'k', 'w', 'y', 'h', 'q'],
                41497
              ),
              ['x', 'j', 'f', 'z', 'k', 'w', 'y', 'h', 'q'],
              72127
            ),
            ['d', 'x', 'j', 'f', 'z', 'k', 'w', 'y', 'h', 'q'],
            128_396
          ),
          ['s', 'd', 'x', 'j', 'f', 'z', 'k', 'w', 'y', 'h', 'q'],
          250_291
        ),
        Fork.new(
          Fork.ne0w(Leaf.new('o', 82762), Leaf.new('l', 83668), ['o', 'l'], 166_430),
          Fork.new(
            Fork.new(Leaf.new('m', 45521), Leaf.new('p', 46335), ['m', 'p'], 91856),
            Leaf.new('u', 96785),
            ['m', 'p', 'u'],
            188_641
          ),
          ['o', 'l', 'm', 'p', 'u'],
          355_071
        ),
        ['s', 'd', 'x', 'j', 'f', 'z', 'k', 'w', 'y', 'h', 'q', 'o', 'l', 'm', 'p', 'u'],
        605_362
      ),
      Fork.new(
        Fork.new(
          Fork.new(
            Leaf.new('r', 100_500),
            Fork.new(
              Leaf.new('c', 50003),
              Fork.new(
                Leaf.new('v', 24975),
                Fork.new(Leaf.new('g', 13288), Leaf.new('b', 13822), ['g', 'b'], 27110),
                ['v', 'g', 'b'],
                52085
              ),
              ['c', 'v', 'g', 'b'],
              102_088
            ),
            ['r', 'c', 'v', 'g', 'b'],
            202_588
          ),
          Fork.new(Leaf.new('n', 108_812), Leaf.new('t', 111_103), ['n', 't'], 219_915),
          ['r', 'c', 'v', 'g', 'b', 'n', 't'],
          422_503
        ),
        Fork.new(
          Leaf.new('e', 225_947),
          Fork.new(Leaf.new('i', 115_465), Leaf.new('a', 117_110), ['i', 'a'], 232_575),
          ['e', 'i', 'a'],
          458_522
        ),
        ['r', 'c', 'v', 'g', 'b', 'n', 't', 'e', 'i', 'a'],
        881_025
      ),
      [
        's',
        'd',
        'x',
        'j',
        'f',
        'z',
        'k',
        'w',
        'y',
        'h',
        'q',
        'o',
        'l',
        'm',
        'p',
        'u',
        'r',
        'c',
        'v',
        'g',
        'b',
        'n',
        't',
        'e',
        'i',
        'a'
      ],
      1_486_387
    )
  end

  def secret() do
    [
      0,
      0,
      1,
      1,
      1,
      0,
      1,
      0,
      1,
      1,
      1,
      0,
      0,
      1,
      1,
      0,
      1,
      0,
      0,
      1,
      1,
      0,
      1,
      0,
      1,
      1,
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      0,
      1,
      0,
      1,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      1,
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      1
    ]
  end
end
