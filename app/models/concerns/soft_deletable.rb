module SoftDeletable
  extend ActiveSupport::Concern

  included do
    # Scopes
    scope(:deleted,      -> { where.not(deleted_at: nil) })
    scope(:not_deleted,  -> { where(deleted_at: nil) })
  end
end
