# Post model
#
# ==== Attributes
#
# * Required
#   * +name+ - The name of the post.
#     * Maximum length 255.
#   * +content+ - The entire text of the post.
class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
end
