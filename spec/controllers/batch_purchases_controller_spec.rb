require 'spec_helper'

describe BatchPurchasesController do
  let(:file) { double "some file upload" }
  let(:upload) do
    ActionDispatch::Http::UploadedFile.new({
      tempfile: file
    })
  end
  let(:batch_purchase) { mock_model(BatchPurchase, save: true, parse_line: true) }
  # This should return the minimal set of attributes required to create a valid
  # BatchPurchase. As you add validations to BatchPurchase, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { file: upload } }

  describe "POST create" do
    describe "with a file upload" do
      before do
        BatchPurchase.stub(:new).and_return batch_purchase
        IO.should_receive(:foreach).with(file).and_yield("first_line").and_yield("second_line").and_yield("third_line")
      end

      it "doesn't parse first line of uploaded file" do
        expect(batch_purchase).to receive(:parse_line).with("first_line").never
        post :create, { :batch_purchase => valid_attributes }
      end

      it "parses subsequent lines of uploaded file" do
        expect(batch_purchase).to receive(:parse_line).with("second_line").once
        expect(batch_purchase).to receive(:parse_line).with("third_line").once
        post :create, { :batch_purchase => valid_attributes }
      end

      it "redirects on save" do
        post :create, { :batch_purchase => valid_attributes }
        response.should redirect_to(batch_purchase)
      end
    end
  end

end
