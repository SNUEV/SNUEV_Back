require 'net/http'
require 'json'
require 'fileutils'

module Crawler
  class Downloader
    CRS_HOST = 'http://sugang.snu.ac.kr:80'.freeze

    def self.parse_config(year, season, options = {})
      ctime = Time.now.localtime.strftime('%Y-%m-%d_%H:%M:%S')
      dirname = Rails.root.join(options.delete(:dir) || 'crawl/data')
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
      xls_path = dirname.join(dirname, "#{year}_#{season}_#{ctime}.xls")

      path = '/sugang/cc/cc100excel.action'

      shtm = {
        'spring': 'U000200001U000300001',
        'autumn': 'U000200002U000300001',
        'summer': 'U000200001U000300002',
        'winter': 'U000200002U000300002'
      }[season.to_sym]
      srchCptnCorsFg = ''
      data = "srchCond=1&pageNo=1&workType=EX&sortKey=&sortOrder=&srchOpenSchyy=#{year}&currSchyy=#{year}&srchOpenShtm=#{shtm}&srchCptnCorsFg=#{srchCptnCorsFg}&srchOpenShyr=&srchSbjtCd=&srchSbjtNm=&srchOpenUpSbjtFldCd=&srchOpenSbjtFldCd=&srchOpenUpDeptCd=&srchOpenDeptCd=&srchOpenMjCd=&srchOpenSubmattCorsFg=&srchOpenSubmattFgCd=&srchOpenPntMin=&srchOpenPntMax=&srchCamp=&srchBdNo=&srchProfNm=&srchTlsnAplyCapaCntMin=&srchTlsnAplyCapaCntMax=&srchTlsnRcntMin=&srchTlsnRcntMax=&srchOpenSbjtTmNm=&srchOpenSbjtTm=&srchOpenSbjtTmVal=&srchLsnProgType=&srchMrksGvMthd=&srchFlag=&inputTextView=&inputText="

      {
        xls_path: xls_path,
        path: path,
        data: data
      }
    end

    def self.download(year, season, options = {})
      if !(year.to_i > 1994) then
        Rails.logger.info "[!] 'year' shuold be greater than 1994"
        raise ArgumentError
      elsif !["spring", "autumn", "summer", "winter"].include?(season) then
        Rails.logger.info "[!] 'season' should be in [spring, autumn, summer, winter]"
        raise ArgumentError
      end

      config = self.parse_config(year, season, options)
      xls_path = config[:xls_path]
      path = config[:path]
      data = config[:data]

      Rails.logger.info "[*] Start fetching..."
      Rails.logger.info "[*] - #{year}/#{season}"

      uri = URI.parse(CRS_HOST)

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.post(path, data)
      end

      open(xls_path, 'wb') do |file|
        file.print(res.body)
      end

      Rails.logger.info '[*] Downloaded:'
      Rails.logger.info "[*] - #{xls_path}"

      xls_path.to_s
    end
  end
end
