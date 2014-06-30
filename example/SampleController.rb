##
# The Sample sevices let you list, create, update, and delete Samples from our application.
# @url /sample
# @topic Sample
#
class SampleController

  ##
  # Retuns all samples, as XML, for the current user that match the given parameters.
  #
  # @url [GET] /samples/index.[format]?[arguments]
  # @url [GET] /samples.[format]?[arguments]
  #
  # @argument [String] format Only "xml" is supported at this time.
  # @argument [String] name The name of the sample
  # @argument [String] reource The resource that sample belongs to
  # @optional_argument ["@assigned"|"@complete"|"!@complete"] search Return jobs that are assigned, complete, or
  #   uncomplete.
  #
  # @example_response
  #   <samples type="array">
  #     <sample>
  #       <id>961</id>
  #       <name>My Sample</name>
  #       <state>complete</state>
  #       <last_unassigned_user_id type="integer"></last_unassigned_user_id>
  #       <resource_id type="integer">127</resource_id>
  #       <notes></notes>
  #       <updated_at type="datetime">2010-03-09T20:43:29Z</updated_at>
  #       <created_at type="datetime">2010-03-09T20:43:16Z</created_at>
  #     </sample>
  #   <samples>
  #
  # @response_field [Integer] id A unique ID identifying the Sample
  # @response_field [String] name The name of the sample
  # @response_field [String] state The current status of the Sample. Can be complete, uncomplete, etc.
  # @response_field [String] notes Any notes given for the sample
  # @response_field [DateTime] updated_at The Date/Time (in ISO8601) that the Sample was last updated
  # @response_field [DateTime] created_at The Date/Time (in ISO8601) that the Sample was created
  #
  def index
  end

  ##
  #
  # Shouldn't be included
  def show
  end

  ##
  # Creates a new sample
  #
  # @url [POST] /samples.[format]?[arguments]
  #
  # @argument [String] format Only "xml" is supported at this time.
  #
  # @example_request
  #   <sample>
  #     <id>961</id>
  #     <name>My Sample</name>
  #     <state>complete</state>
  #     <last_unassigned_user_id type="integer"></last_unassigned_user_id>
  #     <resource_id type="integer">127</resource_id>
  #     <note_attributes type="array">
  #       <note>
  #         <id>new_123</id>
  #         <text>Note One</note>
  #       </note>
  #     </note_attributes>
  #     <updated_at type="datetime">2010-03-09T20:43:29Z</updated_at>
  #     <created_at type="datetime">2010-03-09T20:43:16Z</created_at>
  #   </sample>
  #
  # @request_field [Integer] id A unique ID identifying the Sample
  # @request_field [String] name The name of the sample
  # @request_field [String] state The current status of the Sample. Can be complete, uncomplete, etc.
  # @request_field [String] note_attributes Any notes given for the sample that will be created
  # @request_field [DateTime] updated_at The Date/Time (in ISO8601) that the Sample was last updated
  # @request_field [DateTime] created_at The Date/Time (in ISO8601) that the Sample was created
  #
  # @example_response
  #   <sample>
  #     <id>961</id>
  #     <name>My Sample</name>
  #     <state>complete</state>
  #     <last_unassigned_user_id type="integer"></last_unassigned_user_id>
  #     <resource_id type="integer">127</resource_id>
  #     <notes type="array">
  #       <note>
  #         <text>Note One</note>
  #       </note>
  #     </notes>
  #     <updated_at type="datetime">2010-03-09T20:43:29Z</updated_at>
  #     <created_at type="datetime">2010-03-09T20:43:16Z</created_at>
  #   </sample>
  #
  # @response_field [Integer] id A unique ID identifying the Sample
  # @response_field [String] name The name of the sample
  # @response_field [String] state The current status of the Sample. Can be complete, uncomplete, etc.
  # @response_field [String] notes Any notes given for the sample
  # @response_field [DateTime] updated_at The Date/Time (in ISO8601) that the Sample was last updated
  # @response_field [DateTime] created_at The Date/Time (in ISO8601) that the Sample was created
  #
  def create
  end

end

##
# This one shouldn't show.
#
class BogusController
end

module First
  module Second

    ##
    # Third level deep namespace class
    # @url /otherpath/third
    #
    class Third

      ##
      # Does action!
      # @url [PUT] /otherpath/third/action
      #
      def action
      end

    end

  end
end
