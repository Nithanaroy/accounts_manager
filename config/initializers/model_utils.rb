module ModelUtils
  require 'active_support/inflector'
  def self.included(recipient)
    recipient.extend(ModelClassMethods)
    recipient.class_eval do
      include ModelInstanceMethods
    end
  end # #included directives

  # Class Methods
  module ModelClassMethods
    # A method accessible on model classes
    def whatever

    end
  end

  # Instance Methods
  module ModelInstanceMethods
    #A method accessible on model instances
    def formatted_errors
      error_string = nil
    	if self.errors.any?
        # error_string += "<h3>#{ActiveSupport::Inflector.pluralize(self.errors.count, 'error')} prohibited this payment from being saved:</h3>"
        error_string += "<h2>Correct the following error(s)</h2>"
        error_string += '<ul>'
        self.errors.full_messages.each { |msg| error_string += "<li>#{msg}</li>" }
        error_string += '</ul>'
      end
      error_string
    end
  end
end

#This is where your module is being included into ActiveRecord
if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, ModelUtils)
end