require "spec_helper"

describe "Purchases uploaded via tab delimited file" do

    let(:file_contents) do
<<-PURCHASES        
purchaser name\titem description\titem price\tpurchase count\tmerchant address\tmerchant name
Snake Plissken\t10 off $20 of food\t10.0\t2\t987 Fake St\tBob's Pizza
Amy Pond\t$30 of awesome for $10\t10.0\t5\t456 Unreal Rd\tTom's Awesome Shop
Marty McFl\t$20 Sneakers for $5\t5.0\t1\t123 Fake St\tSneaker Store Emporium
Snake Plissken\t20 Sneakers for $5\t5.0\t4\t123 Fake St\tSneaker Store Emporium}
PURCHASES
    end
    let(:file_name) { Rails.root.join("tmp/purchases_test_file") }
    let(:expected_total_in_dollars) { (2 * 10) + (5 * 10) + (1 * 5) + (4 * 5) }
    
    before do
        File.open(file_name, "w") { |file| file.write(file_contents) }
    end

    after do
        File.delete(file_name)
    end

    describe "uploading the sample file" do
        before do
            visit new_batch_purchase_path
        end

        def upload_file
            attach_file("batch_purchase_upload_file", file_name)
            click_button("Upload")
        end

        it "can upload the sample file" do
            upload_file
            expect(page).to have_content 'Success'
        end

        it "it displays the result" do
            upload_file
            expect(page).to have_content "Gross revenue"
            expect(page).to have_css(".gross-revenue", :text => "$#{expected_total_in_dollars}.00")
        end
    end
end