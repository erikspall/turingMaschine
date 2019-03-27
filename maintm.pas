unit mainTM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  PairSplitter, Grids, StdCtrls, IniPropStorage,lists,inputDialogforTM;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    tmInhalt: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure Edit3EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    //procedure einstellungenLesenUndSetzen();
    procedure moveForward();
    procedure initBand();
    procedure prepareBand();
    procedure moveBackward();
    procedure prepareStringGrid();
    procedure handleMove();
    function loadTM(FileName:String):Boolean;
    procedure Timer1StopTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2StopTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3StartTimer(Sender: TObject);
    procedure Timer3StopTimer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure setViewMode(mode:Integer);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);

  private

  public
    var
  hasMoved:Boolean;
   Band:TListOfPanel;
   zeiger,k:Integer;
   temp,currentZ:Integer;
   hasErw:Boolean;
   bandContent:TListOfString;
   leerzeichen:Char;
   MaschineAl:TListofString;
   Zustand2:TListOfInt;

   delay:Integer;
  end;

var
  Form1: TForm1;
  i:Integer;
  finished:Boolean;
  schritte:Integer;
  animation:Boolean=true;
  lastInputAl:String='';
  lastInputEin:String='';
  breite:Integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   //einstellungenLesenUndSetzen
  breite:=Panel7.Width;
   finished:=true;
   hasMoved:=true;
   currentZ:=1;
   bandContent:=TListOfString.Create;
   Band:=TListOfPanel.Create;
   MaschineAl:=TListOfString.Create;
   Self.DoubleBuffered:=true;
   leerzeichen:='#';
   zeiger := 6;
   for i:=1 to 13 do
   begin
     Band.Add(TPanel(Form1.FindComponent('Panel'+i.toString)));
     Band.getItem(i-1).DoubleBuffered:=true;
     bandContent.Add(leerzeichen);
   end;
   Zustand2:=TListOFInt.Create;
   Zustand2.Add(1);
   setViewMode(0);
end;

procedure TForm1.Edit3EditingDone(Sender: TObject);
Var changed2:boolean;
  prev:Char;
begin
  prev:=leerzeichen;
  if not String(Edit1.Text).Contains(Edit3.Text) then
  begin
  Label3.Caption:='';
  if leerzeichen = Edit3.Text[1] then changed2:=false
  else changed2:=true;
  leerzeichen:=Edit3.TExt[1];
  if changed2 then
  begin
    for i:=0 to bandContent.Count-1 do
    begin
      if bandContent.getItem(i) = prev then bandContent.replaceItem(i,leerzeichen);
    end;
    initBand;
  end;
  Form1.StringGrid1.Cells[1,0]:=leerzeichen;

  end
  else
  begin
    Label3.Caption:='Ungültige Eingabe';
    Edit3.Text:=prev;

  end;
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
  if not lastInputAl.Equals(AnsiUpperCase(Edit1.Text)) then
  begin
    lastInputAl:=AnsiUpperCase(Edit1.Text);
     Edit1.Text:=lastInputAl;
     PrepareStringGrid;
     setViewMode(1);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(zeiger.ToString);
end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
begin
  if not lastInputEin.Equals(AnsiUpperCase(Edit2.Text)) then
  begin
    lastInputEin:=AnsiUpperCase(Edit2.Text);
    Edit2.Text:=lastInputEin;
    prepareBand();
    setViewMode(4);
  end;
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
Var wohin:Char;
begin
    if not ((StringGrid1.Col = 0) or (StringGrid1.Row = 0)) then
    begin
      if Form2.Execute then
      begin
         if Form2.EndZustand then
         begin
            StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:='~Ende~';
         end else
         begin
           case Form2.WhereToGo  of
           -1:Wohin:='L';
           0:Wohin:='0';
           1:Wohin:='R';
           end;
           StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:=Wohin+';'+Form2.WhatToWrite+';Z'+Form2.Zustand.toString;
         end;
      end;
    end;

end;

procedure TForm1.moveForward();
begin
   if hasMoved then begin
  hasMoved:=false;
  temp := band.getItem(0).Left;
  Form1.Timer1.Enabled := True;
  end
else
  begin
  end;
end;

procedure TForm1.initBand();
var d:Integer;
begin

   {for d:=0 to bandContent.Count() -1 do
   begin
      ShowMessage(d.ToString + bandContent.getItem(d));
   end;}

   for i:=0 to band.Count()-1 do
   begin
      //ShowMessage(i.ToString + bandContent.getItem(i));
      //Panel7.Font.Color:=clGreen;
      //Band.getItem(zeiger).Font.Color:=clRed;
      if i >= zeiger then
      Band.getItem(i).Caption:=bandContent.getItem(i)
      else Band.getItem(i).Caption:=leerzeichen;
   end;
end;

procedure TForm1.prepareBand();
Var t:String;
  j:Integer;
  isInvalid:Boolean=false;
begin
   t:=Edit1.Text;
   isInvalid:=false;
   for i:=1 to Length(Edit2.Text) do
   begin
     if t.Contains(Edit2.Text[i]) then
     begin
       Label2.Caption:='';





      end
     else
     begin
       Label2.Caption:='Ungültige Eingabe';
       Edit2.Clear;
       isInvalid:=true;

end;
end;
     if not isInvalid then
     begin
   for j:=0 to Length(Edit2.Text)-1 do
       begin
          if j+zeiger-1<bandContent.Count-1 then
          begin
            //ShowMessage('Replace ' + Edit2.Text[j+1]);
            bandContent.replaceItem(j+6,Edit2.Text[j+1]);
          end
          else
          begin
             bandContent.add(Edit2.Text[j+1]);
            // ShowMessage('Add ' + Edit2.Text[j+1]);
          end;
       end;
       initBand();
       //prepareStringGrid();
   end;

end;

procedure TForm1.moveBackward();
begin
  if hasMoved then begin
  hasMoved:=false;
  temp := Band.getItem(0).Left;
  hasErw := False;
  Form1.Timer2.Enabled := True;
  end;
end;




procedure TForm1.handleMove();
var read:Char;
  X,Y:Integer;
  writeS:String;
  GridRect: TGridRect;
begin
    read:=bandContent.getItem(zeiger)[1];
   // ShowMessage('Read: ' + read);
    for i:=1 to StringGrid1.ColCount-1 do
    begin
      if StringGrid1.Cells[i,0] = read then
      begin
        X:=i;
        break;
      end;
    end;
    for i:=1 to StringGrid1.RowCount-1 do
    begin
      if StrToInt(StringGrid1.Cells[0,i].Chars[1]) = currentZ then
      begin
        Y:=i;
        break;
      end;
    end;
    with GridRect do
     begin
  Top := Y;
  Left := X;
  Right := X;
  Bottom := Y;

     end;
  StringGrid1.Selection := GridRect;
    if StringGrid1.Cells[X,Y] <> '~Ende~'then
    begin
      if StringGrid1.Cells[X,Y].Chars[0] = 'L' then moveBackward();
      if StringGrid1.Cells[X,Y].Chars[0] = 'R' then moveForward();
      writeS:=StringGrid1.Cells[X,Y].Chars[2];
      currentZ:=StrToInt(StringGrid1.Cells[X,Y].Substring(5));
      bandContent.replaceItem(zeiger,writeS);
      band.getItem(6).Caption:=writeS;
    end else
    begin
      finished:=true;
      ToolButton1.Down:=false;
      Timer3.Enabled:=false;
      setViewMode(3);
      ShowMessage('Ende');
    end;

end;

function TForm1.loadTM(FileName: String): Boolean;
Var
    g,h:Integer;
begin
  try
     tmInhalt.IniFileName:=OpenDialog1.FileName;
     tmInhalt.IniSection:='edits';
     Edit2.Text:=tmInhalt.ReadString('eingabewort','');
     Edit3.Text:=tmInhalt.ReadString('leerzeichen','#');
     Edit1.Text:=tmInhalt.ReadString('alphabet','');
     Edit1.EditingDone;
     edit2.EditingDone;
     edit3.EditingDone;


     for g:=tmInhalt.ReadInteger('zustände',2)-1 downto 2 do
     begin
        ToolButton3.Click;
     end;
     tmInhalt.IniSection:='grid';
     h:=1;
      for g:=1 to StringGrid1.RowCount-1 do
      begin
        for i:=1 to StringGrid1.ColCount-1 do
        begin
          StringGrid1.Cells[i,g]:=tmInhalt.ReadString('I'+h.toString,'');
          inc(h);
        end;
      end;
      result:=true;
  except
    result:=false;
  end;

end;

procedure TForm1.Timer1StopTimer(Sender: TObject);
begin
  setViewMode(3);
end;


procedure TForm1.ToolButton5Click(Sender: TObject);
begin
   Timer1.enabled:=false;
  Timer2.enabled:=false;
  Timer3.enabled:=false;
  finished:=true;
  hasMoved:=true;
  currentZ:=1;
  bandContent.Clear;
  band.Clear;
  MaschineAl.Clear;
  Self.DoubleBuffered := True;
  if Edit3.Text <> '' then
  begin
  leerzeichen:=Edit3.Text[1];
  end
  else
  begin
    leerzeichen:='#';
  end;
  zeiger := 6;
  for i := 1 to 13 do
  begin
    Band.Add(TPanel(Form1.FindComponent('Panel' + (i).ToString)));
    Band.getitem(i-1).DoubleBuffered := True;
    Band.getItem(i-1).Left:=(i-2)*breite;
    bandContent.add(leerzeichen);
  end;
  //ShowMessage(band.Count.toString);
     Zustand2.Add(Zustand2.Count+1); //??
     Edit1.text:=AnsiUpperCase(edit1.Text);
  {for i:=0 to Length(Edit1.Text)-1 do
  begin
     if i+zeiger-1 < bandContent.count-1 then
     begin
       bandContent.replaceItem(i+6,Edit1.Text[i+1]);
     end
     else
     begin
       bandContent.add(Edit2.Text[i+1]);
     end;
  end; }
  //initBand();
  prepareBand();
  setViewMode(4);
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
  tempP: TPanel;
begin

  if animation then
  begin
       for i := 0 to band.Count - 1 do
        begin
          Band.getItem(i).Left := Band.getItem(i).Left - 1;
       //   Band.getItem(i).Update;
        end;
       //Update;
  end else
  begin
     for i := 0 to band.Count - 1 do
  begin
    Band.getItem(i).Left := Band.getItem(i).Left - breite;
  end;
  end;
  if Band.getItem(0).Left = temp - breite then
  begin
    if bandContent.count-1 >= (zeiger+7) then   //war 9
    begin
      band.getItem(0).Caption:=bandContent.getItem(zeiger+7);
    end
    else
    begin
      band.getItem(0).Caption:=leerzeichen;
      bandContent.add(leerzeichen);
    end;
    hasMoved:=true;
    timer1.Enabled := False;
    Inc(zeiger);
    tempP := Band.getItem(0);
    Band.getItem(0).Left := Band.getItem(0).Left + breite*13;
    for i := 0 to band.Count - 2 do
    begin
      band.replaceItem(i,Band.getItem(i + 1));
    end;
    Band.replaceItem(band.count - 1,tempP);
  end;


end;

procedure TForm1.Timer2StopTimer(Sender: TObject);
begin
  setViewMode(3);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  tempP: TPanel;
begin

  if not hasErw then
  begin
    hasErw := True;
    tempP := Band.getItem(Band.Count-1);
    if zeiger-7 >= 0 then
    begin
      band.getItem(band.count-1).Caption:=bandContent.getItem(zeiger-7);   //war 6
    end
    else
    begin
      band.getItem(band.count-1).Caption:=leerzeichen;
      bandContent.insertItem(leerzeichen,0);
      Inc(Zeiger);
    end;
    Band.getItem(band.count-1).Left := Band.getItem(band.count-1).Left - breite*13; //hmmmm
    for i := band.count - 1 downto 1 do
    begin
      band.replaceItem(i,band.getItem(i-1));
    end;
    Band.replaceItem(0,tempP);
  end;
  if animation then
  begin
  for i := 0 to band.Count-1 do
  begin
    Band.getItem(i).Left := Band.getItem(i).Left + 1;
   // Band.getItem(i).Update;
  end;
  // Update;
   end else
   begin
     for i := 0 to band.Count-1 do
  begin
    Band.getItem(i).Left := Band.getItem(i).Left + breite;
  end;
   end;
  if Band.getItem(1).Left = temp + breite then
  begin
    timer2.Enabled := False;
    hasMoved:=true;
    Dec(Zeiger);
  end;

end;

procedure TForm1.Timer3StartTimer(Sender: TObject);
begin
  handleMove();
  if finished then Timer3.Enabled:=false;
end;

procedure TForm1.Timer3StopTimer(Sender: TObject);
begin
  setViewMode(3);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
   while (not finished) and (hasMoved) do
begin
  handleMove();
  if finished then Timer3.Enabled:=false;
end;
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  setViewMode(2);
  moveForward();
 // setViewMode(3);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin

   if finished then finished:=false;
   schritte:=1;
   Timer3.Enabled:=true;
   setViewMode(2);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Zustand2.add(Zustand2.Count+1);
  with StringGrid1 do
begin
   RowCount:=RowCount+1;
   Cells[0,RowCount-1]:='Z'+Zustand2.getItem(Zustand2.Count-1).toString;
   end;

end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  if StringGrid1.RowCount > 2 then
  begin
  Zustand2.deleteItemAt(Zustand2.Count-1);
  with StringGrid1 do
   RowCount:=RowCount-1;
 end;

end;

procedure TForm1.setViewMode(mode: Integer);
begin
   case mode of
   0:begin //Nach Start, wenn nichts eingetragen
     GroupBox1.Enabled:=true;
     GroupBox2.Enabled:=false;
     GroupBox3.Enabled:=false;
     StringGrid1.enabled:=false;
     Toolbutton1.Enabled:=false;
     Toolbutton2.Enabled:=true;
     Toolbutton3.Enabled:=false;
     Toolbutton4.Enabled:=false;
     Toolbutton5.Enabled:=false;
     Toolbutton6.Enabled:=true;
     Toolbutton7.Enabled:=false;
     Toolbutton8.Enabled:=true;
     ToolButton9.Enabled:=false;
     ToolButton10.Enabled:=false;
   end;
   1:begin     //Das Alphabet wurde eingegeben
     GroupBox1.Enabled:=true;
     GroupBox2.Enabled:=true;
     GroupBox3.Enabled:=true;
     StringGrid1.enabled:=true;
     Toolbutton1.Enabled:=true;
     Toolbutton2.Enabled:=true;
     Toolbutton3.Enabled:=true;
     Toolbutton4.Enabled:=true;
     Toolbutton5.Enabled:=false;
     Toolbutton6.Enabled:=true;
     Toolbutton7.Enabled:=true;
     Toolbutton8.Enabled:=true;
     ToolButton9.Enabled:=false;
     ToolButton10.Enabled:=false;
   end;
   2:begin //tm läuft aktuell
     GroupBox1.Enabled:=false;
     GroupBox2.Enabled:=false;
     GroupBox3.Enabled:=false;
     StringGrid1.enabled:=false;
     Toolbutton1.Enabled:=false;
     Toolbutton2.Enabled:=true;
     Toolbutton3.Enabled:=false;
     Toolbutton4.Enabled:=false;
     Toolbutton5.Enabled:=true;
     Toolbutton6.Enabled:=true;
     Toolbutton7.Enabled:=false;
     Toolbutton8.Enabled:=false;
     ToolButton9.Enabled:=false;
     ToolButton10.Enabled:=false;
   end;
   3:begin //tm ist fertig
     GroupBox1.Enabled:=true;
     GroupBox2.Enabled:=true;
     GroupBox3.Enabled:=true;
     StringGrid1.enabled:=true;
     Toolbutton1.Enabled:=true;
     Toolbutton2.Enabled:=true;
     Toolbutton3.Enabled:=true;
     Toolbutton4.Enabled:=true;
     Toolbutton5.Enabled:=true;
     Toolbutton6.Enabled:=true;
     Toolbutton7.Enabled:=true;
     Toolbutton8.Enabled:=true;
     ToolButton9.Enabled:=true;
     ToolButton10.Enabled:=true;
   end;
   4:begin //wurde resettet / startbereit
     GroupBox1.Enabled:=true;
     GroupBox2.Enabled:=true;
     GroupBox3.Enabled:=true;
     StringGrid1.enabled:=true;
     Toolbutton1.Enabled:=true;
     Toolbutton2.Enabled:=true;
     Toolbutton3.Enabled:=true;
     Toolbutton4.Enabled:=true;
     Toolbutton5.Enabled:=false;
     Toolbutton6.Enabled:=true;
     Toolbutton7.Enabled:=true;
     Toolbutton8.Enabled:=true;
     ToolButton9.Enabled:=true;
     ToolButton10.Enabled:=true;
   end;
end;

end;

procedure TForm1.ToolButton7Click(Sender: TObject);
Var
   g,h:Integer;
begin
    if SaveDialog1.Execute then
    begin
    tmInhalt.IniFileName:=SaveDialog1.FileName;
    tmInhalt.IniSection:='edits';
    tmInhalt.WriteString('eingabewort',Edit2.Text);
    tmInhalt.WriteString('leerzeichen',Edit3.Text);
    tmInhalt.WriteString('alphabet',Edit1.Text);
    tmInhalt.WriteInteger('zustände',StringGrid1.RowCount);
    tmInhalt.IniSection:='grid';
    h:=1;
    for g:=1 to StringGrid1.RowCount-1 do
    begin
       for i:=1 to StringGrid1.ColCount-1 do
       begin
         tmInhalt.WriteString('I'+h.toString,StringGrid1.Cells[i,g]);
         Inc(h);
       end;
    end;
    end;

end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
       loadTM(OpenDialog1.FileName);
  end;
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  setViewMode(2);
  moveBackward();
 // setViewMOde(3);
end;

procedure TForm1.prepareStringGrid();
Var rawA:String;
  Col:Integer;
  j:Integer;
  isIn:Boolean;
begin
   rawA:=Edit1.Text;
   Zustand2.Clear;
   Zustand2.Add(1);

   for i:=1 to Length(rawA) do
   begin
      if not 'ABCDEFGHIJKLMNOPQRSTUVWXYZ+-/0123456789'.Contains(rawA[i]) and (rawA[i]<>leerzeichen) then
      begin
        Delete(rawA,i,1);
      end;
   end;


   isIn:=false;
   StringGrid1.ColCount:=2;
   StringGrid1.Cells[1,0]:=leerzeichen;
   for j:=1 to Length(rawA) do    //Durchlaufe Eingabe
   begin
     isIn:=false;
        for Col:=1 to StringGrid1.ColCount-1 do   //Durchlaufe Cols
        begin
          if rawA[j] = StringGrid1.Cells[Col,0] then  //Wenn Char in Cols isIn True
          begin
            isIn:=true;
          end;
        end;
        if not isIn then                 //Wenn Char nicht in Col = Hinzufügen
        begin
          StringGrid1.ColCount:=StringGrid1.ColCount+1;
          StringGrid1.Cells[Col+1,0]:=rawA[j];
           Inc(Col);
           isIn:=false;
        end;
   end;
   isIn:=false;
   StringGrid1.RowCount:=Zustand2.Count+1;
   for i:=1 to StringGrid1.RowCount-1 do
   begin
     StringGrid1.Cells[0,i]:='Z'+Zustand2.getItem(i-1).toString;
   end;


end;



end.

