# -*- coding: utf-8 -*-
module ApplicationsHelper

  def createFDF(info)

    data = "%FDF-1.2\n" # header
    data.force_encoding('utf-8')
    data += "%âãÏÓ\n"
    data += "1 0 obj\n<<" # open the Root dictionary
    data += "\n/FDF << " # open the FDF dictionary
    data += "/Fields [ " # open the form Fields array

    info.each { |key,value|
        data += '<</T(' + key + ')/V(' + value.to_s.strip + ')>>'
    }

    data += "] " # close the Fields array
    data += ">> \n" # close the FDF dictionary
    data += ">> \nendobj\n" # close the Root dictionary
    # trailer note the "1 0 R" reference to "1 0 obj" above
    data += "trailer\n<<\n/Root 1 0 R \n\n>>\n"
    data += "%%EOF\s\n"
    afile = File.new("/tmp/rails_" + rand.to_s, "w") << data
    afile.close
    return afile
  end

end
