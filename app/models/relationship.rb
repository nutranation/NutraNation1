# == Schema Information
# Schema version: 20100831012055
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :item_type
  
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"
  has_many :notifications, :as => :item, :dependent => :destroy
  
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
  validates :item_type, :presence => true
  
  after_create :send_follower_email
  
  def send_follower_email
    if self.item_type == 'User'
      UserMailer.follower_email(self).deliver
    end
  end
  
  def self.unique_chars?(str)
    char = []
    str.each_byte { |s| char << s }
    char.size == char.uniq.size ? true : false
  end
  def anagram?(str)
    str == str.reverse ? true:false
  end
  
  def self.anagram_sort(arr)
    arr.sort do |e1, e2|
      e1 =  e1 == e1.reverse ? 0 : 1
      e2 =  e2 == e2.reverse ? 0 : 1
      e1 <=> e2
    end
  end
  
  def self.reformat(str)
    str.gsub(' ', '%20')
  end
  
  def self.rows(aoa)
    columns = []
    rows = []
    aoa.each_with_index do |a,j|
      a.each_with_index do |s, i|
        if s == 0
          rows << j
          columns << i
        end
      end
    end 
    puts rows.inspect
    rows.each do |r|
      puts aoa[r].inspect
      aoa[r].each { |s| s = 0 }
      puts aoa[r].inspect
    end
    columns.each do |c|
      aoa.each { |a| a[c] = 0 }
    end
    aoa
  end
  def self.duplicate(raw)
    final = []
    raw.each do |r|
      final << r unless final.include?(r)
    end
    final
  end
    
  
end
