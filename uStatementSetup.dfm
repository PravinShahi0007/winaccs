�
 TFORMSTATEMENTSETUP 0�  TPF0TFormStatementSetupFormStatementSetupLeft Top� Width�Height�CaptionStatement SetupColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoScreenCenterOnShowFormShowPixelsPerInch`
TextHeight TLabelLabel1Left@Top� WidthtHeightCaptionShow Statement Header  TLabelLabel2Left@Top� WidthwHeightCaptionInclude 'Statement From'   TLabelLabel3Left@Top� WidthHeightCaptionName  TLabelLabel4Left@Top� Width,HeightCaptionAddress1  TLabelLabel5Left@TopWidth,HeightCaptionAddress2  TLabelLabel6Left@Top(Width,HeightCaptionAddress3  TLabelLabel7Left@Top@Width,HeightCaptionAddress4  TLabelLabel8Left0Top(WidthaHeightCaptionKThis setup screen allows you to set up what to be printed on the statement,WordWrap	  TLabelLabel9Left0Top@WidthBHeightCaptionFStatement Header is the line across the top with Sale Statement in it.  TLabelLabel10Left0TopXWidth>HeightCaptionGIf you want to print the heading 'Statement From' tick to indicate this  TLabelLabel11Left0ToppWidthmHeightCaptionOIf you want the program to print your name and address, fill in the boxes below  TLabelLabel12Left0Top� WidthHeightCaption;If using preprinted stationary, leave the boxes below blank  TLabelLabel13Left@TopXWidth3HeightCaption	Telephone  TLabelLabel25Left@ToptWidth� HeightCaption!Use .bmp graphics file for header  TButton
ExitButtonLeftTopWidthKHeightCaptionSave && E&xitTabOrder OnClickExitButtonClick  TDBEditDBEdit1Left� Top� Width� Height	DataFieldname
DataSourceAccsDataModule.dsStatementTabOrder  TDBEditDBEdit2Left� Top� Width� Height	DataFieldAddress1
DataSourceAccsDataModule.dsStatementTabOrder  TDBEditDBEdit3Left� TopWidth� Height	DataFieldAddress2
DataSourceAccsDataModule.dsStatementTabOrder  TDBEditDBEdit4Left� Top Width� Height	DataFieldAddress3
DataSourceAccsDataModule.dsStatementTabOrder  TDBEditDBEdit5Left� Top8Width� Height	DataFieldAddress4
DataSourceAccsDataModule.dsStatementTabOrder  TDBCheckBoxDBCheckBox1Left� Top� WidthaHeight	DataField
showheader
DataSourceAccsDataModule.dsStatementTabOrderValueCheckedTrueValueUncheckedFalse  TDBCheckBoxDBCheckBox2Left� Top� WidthaHeight	DataFieldstatementfrom
DataSourceAccsDataModule.dsStatementTabOrderValueCheckedTrueValueUncheckedFalse  TDBEditDBEdit6Left� TopPWidth� Height	DataField	Telephone
DataSourceAccsDataModule.dsStatementTabOrder  TDBEditStatementTypeDBEditLeft`Top� WidthIHeight	DataField	statetype
DataSourceAccsDataModule.dsStatementTabOrder	Visible  TDBCheckBoxDBCheckBox20Left� ToprWidthHeightCaptionDBCheckBox20	DataFieldUseGraphicsFile
DataSourceAccsDataModule.dsStatementTabOrder
ValueCheckedTrueValueUncheckedFalse  TDBEditDBEdit7Left� Top�Width� Height	DataFieldGraphicsFileName
DataSourceAccsDataModule.dsStatementTabOrder  TBitBtn	BrowseBtnLeft� ToppWidthKHeightCaptionBrowseTabOrderOnClickBrowseBtnClick
Glyph.Data
�   �   BM�       v   (               �                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� �������D������L��������������L�M����Ԏ����DDHM���ffG����n��dM�������M�������M�������M�������M�������M��������������M�����������  TOpenDialogOpenDialog1
DefaultExt*.bmpFilterBitmap|*.bmp
InitialDirc:\kingsaccLeft�Top�    