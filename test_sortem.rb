require "minitest/autorun"
require_relative "sortem"

class TestSortem < Minitest::Test
  def setup
  end

  def test_that_same_users_are_filtered
    same_user_set = [
      ["Sys1", "User", 1234, "text"],
      ["Sys2", "User", 1234, "text"],
      ["Sys3", "User", 1234, "text"],
    ]

    same_users_filtered = Sortem.new(same_user_set).result

    assert_equal same_users_filtered, []
  end

  def test_that_different_users_are_filtered
    different_user_set = [
      ["Sys1", "User", 1234, "text"],
      ["Sys2", "User", 1234, "text"],
      ["Sys3", "User", 1234, "text"],
    ]
    different_users_filterd = Sortem.new(different_user_set).result

    assert_equal different_users_filterd, []
  end

  def test_that_partially_matching_users_kept
    polluted_user_set = [
      ["Sys1", "User", 4567, "text"],
      ["Sys2", "User", 1234, "text"],
    ]
    polluted_users_filtered = Sortem.new(polluted_user_set).result

    assert_equal polluted_users_filtered, []
  end

  def test_that_multiple_partially_matching_users_kept
    polluted_user_set = [
      ["Sys2", "User", 1234, "text"],
      ["Sys1", "Uzer", 1234, "text"],
      ["Sys3", "User", 1234, "text"],
    ]
    polluted_users_filtered = Sortem.new(polluted_user_set).result

    assert_equal polluted_users_filtered, [polluted_user_set]
  end
end
