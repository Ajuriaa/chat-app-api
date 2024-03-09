require_relative 'connection_helpers'

class ChatAppApiSchema < GraphQL::Schema
  # Include connections for pagination
  include ConnectionHelpers

  mutation(Types::MutationType)
  query(Types::QueryType)
end
