require 'spec_helper'

describe Alert do
  before do
    @xml = '<?xml version="1.0" encoding="utf-8"?> 
<methodResponse> 
<params> 
 <param> 
  <value> 
   <struct> 
    <member>
     <name>ba2930d8f5addce9065c0af8a15a1f97</name>
     <value>
      <struct>
       <member>
        <name>title</name>
        <value>
         <string>OSU Emergency Notification Test </string>
        </value>
       </member>
       <member>
        <name>body</name>
        <value>
         <string>&#60;h6 class=&#34;uiStreamMessage&#34;&#62;&#60;span class=&#34;messageBody&#34;&#62;This is a TEST message from the OSU emergency alert system. To update your emergency alert contact information please go to &#60;a href=&#34;http://oregonstate.edu/main/alerts/portal&#34;&#62;http://oregonstate.edu/main/alerts/portal&#60;/a&#62;&#60;/span&#62;&#60;/h6&#62;</string>
        </value>
       </member>
       <member>
        <name>sticky</name>
        <value>
         <string/>
        </value>
       </member>
       <member>
        <name>created</name>
        <value>
         <string>1297798284</string>
        </value>
       </member>
       <member>
        <name>nid</name>
        <value>
         <string>634</string>
        </value>
       </member>
       <member>
        <name>changed</name>
        <value>
         <string>1297799257</string>
        </value>
       </member>
       <member>
        <name>id</name>
        <value>
         <string>ba2930d8f5addce9065c0af8a15a1f97</string>
        </value>
       </member>
       <member>
        <name>date</name>
        <value>
         <string>1297799257</string>
        </value>
       </member>
       <member>
        <name>date_string</name>
        <value>
         <string>February 15, 11:47 am</string>
        </value>
       </member>
       <member>
        <name>expire_date</name>
        <value>
         <int>1299879902</int>
        </value>
       </member>
       <member>
        <name>category</name>
        <value>
         <string>safety</string>
        </value>
       </member>
       <member>
        <name>summary</name>
        <value>
         <string>This is a TEST message from the OSU emergency alert system. To update your emergency alert contact information please go to http://oregonstate.edu/main/alerts/portal.&#38;hellip; </string>
        </value>
       </member>
       <member>
        <name>active</name>
        <value>
         <int>0</int>
        </value>
       </member>
       <member>
        <name>removed</name>
        <value>
         <int>1</int>
        </value>
       </member>
      </struct>
     </value>
    </member>
    <member>
     <name>ba4230d8f5addce9065c0af8a15a1f97</name>
     <value>
      <struct>
       <member>
        <name>title</name>
        <value>
         <string>FREE FOOD!!</string>
        </value>
       </member>
       <member>
        <name>body</name>
        <value>
         <string>there is free food at mu quad</string>
        </value>
       </member>
       <member>
        <name>sticky</name>
        <value>
         <string/>
        </value>
       </member>
       <member>
        <name>created</name>
        <value>
         <string>1297798284</string>
        </value>
       </member>
       <member>
        <name>nid</name>
        <value>
         <string>634</string>
        </value>
       </member>
       <member>
        <name>changed</name>
        <value>
         <string>1297799257</string>
        </value>
       </member>
       <member>
        <name>id</name>
        <value>
         <string>ba2930d8f5addce9065c0af8a15a1f97</string>
        </value>
       </member>
       <member>
        <name>date</name>
        <value>
         <string>1297799257</string>
        </value>
       </member>
       <member>
        <name>date_string</name>
        <value>
         <string>February 15, 11:47 am</string>
        </value>
       </member>
       <member>
        <name>expire_date</name>
        <value>
         <int>1299879902</int>
        </value>
       </member>
       <member>
        <name>category</name>
        <value>
         <string>safety</string>
        </value>
       </member>
       <member>
        <name>summary</name>
        <value>
         <string>FREE FOOD</string>
        </value>
       </member>
       <member>
        <name>active</name>
        <value>
         <int>0</int>
        </value>
       </member>
       <member>
        <name>removed</name>
        <value>
         <int>1</int>
        </value>
       </member>
      </struct>
     </value>
    </member>
   </struct> 
  </value> 
 </param> 
</params> 
</methodResponse>'
    @alert_items = [{:hash => 'ba2930d8f5addce9065c0af8a15a1f97',
                       :title => 'OSU Emergency Notification Test ',
                       :date => Time.at(1297798284),
                       :summary => '<h6 class="uiStreamMessage"><span class="messageBody">This is a TEST message from the OSU emergency alert system. To update your emergency alert contact information please go to <a href="http://oregonstate.edu/main/alerts/portal">http://oregonstate.edu/main/alerts/portal</a></span></h6>'},
                      {:hash => 'ba4230d8f5addce9065c0af8a15a1f97',
                       :title => 'FREE FOOD!!',
                       :date =>  Time.at(1297798284),
                       :summary => 'there is free food at mu quad'}
                     ]
  end

  it 'should parse alert items correctly' do
    feed = Alert.parse(@xml)
    feed.should == @alert_items
  end

  it 'should save an valid alert' do
    old_count = Alert.count
    Alert.create!(@alert_items[0])
    Alert.count.should == old_count+1
  end
end
