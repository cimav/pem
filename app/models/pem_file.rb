class PemFile < ApplicationRecord
  before_create :set_status

  ACTIVE = 1
  DELETED =99

  def set_status
    self.status = 1
  end

end
