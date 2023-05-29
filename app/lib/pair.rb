require './db/db'
require 'securerandom'

class Pair
  def initialize(long: long, short: short )
    @long = long
    @short = short
  end

  def short
    @short ||= get_short
  end

  def long
    @long ||= get_long
  end

  def get_long
    DB.find_by(short: short)
  end

  def get_short
    DB.find_by(long: long) || DB.create(long, create_uri)
  end

  def create_uri
    SecureRandom.urlsafe_base64(3)
  end

  def empty?
    short & long
  end
end