module PdfMaker
    class << self
        def registered(app)
            app.after_build do |builder|
              outfile = "build/Jordan Running - Resume.pdf"

                begin
                    require 'pdfkit'

                    kit = PDFKit.new(File.new('build/index.html'),
                                :margin_top => 10,
                                :margin_bottom => 0,
                                :margin_left => 0,
                                :margin_right => 0,
                                # :disable_smart_shrinking => true,
                                :print_media_type => true,
                                :dpi => 96)

                    file = kit.to_file(outfile)

                    rescue Exception =>e
                        builder.say_status "PDF Maker",  "Error: #{e.message}", Thor::Shell::Color::RED
                        raise
                    end
                    builder.say_status "PDF Maker",  "PDF file available at #{outfile}"
                end


            end
            alias :included :registered
        end
    end

::Middleman::Extensions.register(:pdfmaker, PdfMaker)
