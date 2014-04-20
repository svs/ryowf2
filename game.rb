REDIS = Redis.new
class Game
  def self.all
    REDIS.lrange("CHESS:ids", 0, -1)
  end

  def self.create
    id = REDIS.lrange("CHESS:ids", -1, -1)[-1].to_i + 1
    REDIS.rpush("CHESS:ids", id)
    id
  end

  def self.find(id)
    return false unless all.include?(id.to_s)
    self.new(id)
  end

  def initialize(id)
    @id = id
  end

  def add_move(move)
    REDIS.rpush("CHESS:#{@id}", move)
  end

  def moves
    REDIS.lrange("CHESS:#{@id}",0, -1)
  end

  def to_json
    moves.to_json
  end

  def ok?
    true
  end
end
