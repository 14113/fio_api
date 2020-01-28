module FioAPI
  module Payments
    module Xml
      class Root
        XSI_OPTIONS = {
          'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
          'xsi:noNamespaceSchemaLocation' => 'http://www.fio.cz/schema/importIB.xsd'
        }.freeze

        attr_reader :payments

        def initialize(payments)
          @payments = payments
        end

        def build
          @build ||= Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
            xml.Import(XSI_OPTIONS) do
              xml.Orders do
                payments.each do |payment|
                  klass = payment.xml_item_class
                  klass.new(xml, payment).build
                end
              end
            end
          end.to_xml
        end
      end
    end
  end
end
