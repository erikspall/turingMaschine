unit tMaschine;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, DividerBevel, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, EditBtn, Grids, Menus, IniPropStorage,
  PairSplitter, obtlist, inputDialogforTM, Dos, settings;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    DividerBevel1: TDividerBevel;
    Edit1: TEdit;
    EditButton1: TEditButton;
    EditButton2: TEditButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Image1: TImage;
    IniFile: TIniPropStorage;
    tmInhalt: TIniPropStorage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    OpenDialog1: TOpenDialog;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SaveDialog1: TSaveDialog;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton2ButtonClick(Sender: TObject);
    procedure EditButton2EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure einstellungenLesenUndSetzen();
    procedure StringGrid1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure moveForward();
    procedure initBand();
    procedure moveBackwards();
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3StartTimer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure prepareStringGrid();
    procedure handleMove();
    function loadTM(FileName:String):Boolean;
    function funHatParameter: boolean;
  private

  public
     Var   hasMoved:Boolean;
  Band: array[0..13] of TPanel;
  zeiger,k: integer;
  temp,currentZ: integer;
  hasErw: boolean;
  bandContent: StringList;
  leerzeichen:char;
   MaschineAl: StringList;
   Zustand2:Array of Integer;
   animation:Boolean;
         delay:Integer;
  end;

var
  Form1: TForm1;
  i:Integer;
  finished:Boolean;
  schritte:Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if funHatParameter then
  loadTM(ParamStr(1));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  moveBackwards();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SetLength(Zustand2,Length(Zustand2)+1);
  Zustand2[Length(Zustand2)-1]:=Length(Zustand2);
  with StringGrid1 do
  begin
       RowCount:=RowCount+1;
       Cells[0,RowCount-1]:='Z'+Zustand2[Length(Zustand2)-1].ToString;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.text:=AnsiUpperCase(edit1.Text);
  for i:=0 to Length(Edit1.Text)-1 do
  begin
     if i+zeiger-1 < bandContent.size-1 then
     begin
       bandContent.replaceItem(i+5,Edit1.Text[i+1]);
     end
     else
     begin
       bandContent.addItem(Edit1.Text[i+1]);
     end;
  end;
  initBand();
  PrepareStringGrid;
end;

procedure TForm1.Button5Click(Sender: TObject);

begin
  if finished then finished:=false;
  schritte:=1;
  Timer3.Enabled:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Timer1.enabled:=false;
  Timer2.enabled:=false;
  Timer3.enabled:=false;
  finished:=true;
  hasMoved:=true;
  currentZ:=1;
  bandContent.Clear;
  MaschineAl.Clear;
  Self.DoubleBuffered := True;
  if EditButton1.Text <> '' then
  begin
  leerzeichen:=EditButton1.Text[1];
  end
  else
  begin
    leerzeichen:='#';
  end;
  zeiger := 5;
  for i := 0 to 13 do
  begin
    Band[i] := TPanel(Form1.FindComponent('Panel' + (i + 1).ToString));
    Band[i].DoubleBuffered := True;
    Band[i].Left:=i*100;
    bandContent.addItem(leerzeichen);
  end;
     SetLength(Zustand2,Length(Zustand2)+1);
     Zustand2[Length(Zustand2)]:=1;
     Edit1.text:=AnsiUpperCase(edit1.Text);
  for i:=0 to Length(Edit1.Text)-1 do
  begin
     if i+zeiger-1 < bandContent.size-1 then
     begin
       bandContent.replaceItem(i+5,Edit1.Text[i+1]);
     end
     else
     begin
       bandContent.addItem(Edit1.Text[i+1]);
     end;
  end;
  initBand();
end;

procedure TForm1.EditButton1ButtonClick(Sender: TObject);
var changed2:boolean;
  prev:Char;
begin
  prev:=leerzeichen;
  if leerzeichen = EditButton1.Text[1] then changed2:= false
  else changed2:=true;
  leerzeichen:=EditButton1.Text[1];
  if changed2 then
  begin
    for i:=0 to bandContent.size()-1 do
    begin
       if bandContent.getItem(i) = prev then bandContent.replaceItem(i,leerzeichen);
    end;
    initBand;
  end;
  Form1.StringGrid1.Cells[1,0]:=leerzeichen;
end;

procedure TForm1.EditButton2ButtonClick(Sender: TObject);
begin
  PrepareStringGrid;
end;

procedure TForm1.EditButton2EditingDone(Sender: TObject);
begin
  EditButton2.Text:=AnsiUpperCase(EditButton2.Text);
end;

procedure TForm1.moveForward();
begin
if hasMoved then begin
  hasMoved:=false;
  temp := Band[0].Left;
  Form1.Timer1.Enabled := True;
  end
else
  begin
  end;
end;


procedure TForm1.moveBackwards();
begin
if hasMoved then begin
  hasMoved:=false;
  temp := Band[0].Left;
  hasErw := False;
  Form1.Timer2.Enabled := True;
  end;
end;

procedure TForm1.initBand();
begin
  for i:=0 to 13 do
  begin
     if i>=zeiger then
     Band[i].Caption:=bandContent.getItem(i)
     else Band[i].Caption:=leerzeichen;
  end;
end;



procedure TForm1.Timer2Timer(Sender: TObject);
var
  tempP: TPanel;
begin
  if not hasErw then
  begin
    hasErw := True;
    tempP := Band[Length(Band) - 1];
    if zeiger-6 >= 0 then
    begin
      band[Length(Band)-1].Caption:=bandContent.getItem(zeiger-6);
    end
    else
    begin
      band[Length(Band)-1].Caption:=leerzeichen;
      bandContent.insertItem(leerzeichen,0);
      Inc(Zeiger);
    end;
    Band[Length(Band) - 1].Left := Band[Length(Band) - 1].Left - 1400;
    for i := Length(Band) - 1 downto 1 do
    begin
      Band[i] := Band[i - 1];
    end;
    Band[0] := tempP;
  end;
  if animation then
  begin
  for i := 0 to Length(Band) - 1 do
  begin
    Band[i].Left := Band[i].Left + 1;
  end;
   end else
   begin
     for i := 0 to Length(Band) - 1 do
  begin
    Band[i].Left := Band[i].Left + 100;
  end;
   end;
  if Band[1].Left = temp + 100 then
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

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  while (not finished) and (hasMoved) do
  begin
       handleMove();
       if finished then Timer3.Enabled:=false;
  end;
end;

procedure TForm1.prepareStringGrid();
Var rawA:String;
  Col:Integer;
  j:Integer;
  isIn:Boolean;
begin
   rawA:=Edit1.Text;
   SetLength(Zustand2,0);
    SetLength(Zustand2,Length(Zustand2)+1);
     Zustand2[Length(Zustand2)]:=1;
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
   if (Length(EditButton2.Text)<>0) and (EditButton2.Text <> ',') and (EditButton2.Text <> '') then
   begin
     for i:=1 to Length(EditButton2.Text) do
     begin
       if EditButton2.text[i] <> ',' then
       begin
          for Col:=1 to StringGrid1.ColCount-1 do
          begin
            if EditButton2.Text[i] = StringGrid1.Cells[Col,0] then
            begin
              isIn:=true;
            end;
          end;
          if not isIn then
          begin
            StringGrid1.ColCount:=StringGrid1.ColCount+1;
            StringGrid1.Cells[Col+1,0]:=EditButton2.Text[i];
            Inc(Col);
          end;
          isIn:=false;
       end
       else if EditButton2.Text[i] = ',' then
       begin
         //Do Nothing
       end
       else
       begin
         //Do Nothing
       end;
     end;
   end;
   StringGrid1.RowCount:=Length(Zustand2)+1;
   for i:=1 to StringGrid1.RowCount-1 do
   begin
     StringGrid1.Cells[0,i]:='Z'+Zustand2[i].toString;
   end;
end;

procedure TForm1.handleMove();
var read:Char;
  X,Y:Integer;
  writeS:String;
  GridRect: TGridRect;
begin
    read:=bandContent.getItem(zeiger)[1];
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
  GridRect.Top := Y;
  GridRect.Left := X;
  GridRect.Right := X;
  GridRect.Bottom := Y;
  StringGrid1.Selection := GridRect;
    if StringGrid1.Cells[X,Y] <> '- Ende -'then
    begin
      if StringGrid1.Cells[X,Y].Chars[0] = 'L' then moveBackwards();
      if StringGrid1.Cells[X,Y].Chars[0] = 'R' then moveForward();
      writeS:=StringGrid1.Cells[X,Y].Chars[2];
      currentZ:=StrToInt(StringGrid1.Cells[X,Y].Substring(5));
      bandContent.replaceItem(zeiger,writeS);
      band[5].Caption:=writeS;
    end else
    begin
      finished:=true;
      Timer3.Enabled:=false;
      ShowMessage('Ende');
    end;
end;

function TForm1.funHatParameter: boolean;
begin
   Result := False;

  // Prüft, ob es Parameter jenseits
  // von ParamStr(0) gibt
  if ParamCount > 0 then
    Result := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  einstellungenLesenUndSetzen;
  finished:=true;
  hasMoved:=true;
  currentZ:=1;
  bandContent.Create;
  MaschineAl.Create;
  Self.DoubleBuffered := True;
  leerzeichen:='#';
  zeiger := 5;
  for i := 0 to 13 do
  begin
    Band[i] := TPanel(Form1.FindComponent('Panel' + (i + 1).ToString));
    Band[i].DoubleBuffered := True;
    bandContent.addItem(leerzeichen);
  end;
  SetLength(Zustand2,Length(Zustand2)+1);
  Zustand2[Length(Zustand2)]:=1;
  //FileAssociation1.Execute;

end;

procedure TForm1.MenuItem2Click(Sender: TObject); //Speichern
Var
   g,h:Integer;
begin
    if SaveDialog1.Execute then
    begin
    tmInhalt.IniFileName:=SaveDialog1.FileName;
    tmInhalt.IniSection:='edits';
    tmInhalt.WriteString('eingabewort',Edit1.Text);
    tmInhalt.WriteString('leerzeichen',EditButton1.Text);
    tmInhalt.WriteString('alphabet',EditButton2.Text);
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

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
    begin
    loadTM(OpenDialog1.FileName);
   end;
end;

function TForm1.loadTM(FileName:String):Boolean;
Var
    g,h:Integer;
begin
  try
     tmInhalt.IniFileName:=OpenDialog1.FileName;
     tmInhalt.IniSection:='edits';
     Edit1.Text:=tmInhalt.ReadString('eingabewort','');
     EditButton1.Text:=tmInhalt.ReadString('leerzeichen','#');
     EditButton2.Text:=tmInhalt.ReadString('alphabet','');
     Button4.Click;
     EditButton1.Button.Click;
     EditButton2.Button.Click;
     for g:=tmInhalt.ReadInteger('zustände',2)-1 downto 2 do
     begin
        MenuItem5.Click;
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


procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  SetLength(Zustand2,Length(Zustand2)+1);
  Zustand2[Length(Zustand2)-1]:=Length(Zustand2);
  with StringGrid1 do
  begin
       RowCount:=RowCount+1;
       Cells[0,RowCount-1]:='Z'+Zustand2[Length(Zustand2)-1].ToString;
  end;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  if Length(Zustand2) > 1 then
  begin
   SetLength(Zustand2,Length(Zustand2)-1);
    with StringGrid1 do
    begin
         RowCount:=RowCount-1;
    end;
  end;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  Form3.ShowModal;
  Timer3.Interval:=delay;
end;

procedure TForm1.einstellungenLesenUndSetzen();
begin
     if FileExists('settings.ini') then
     begin
        IniFile.IniSection:='settings';
        animation:=IniFile.ReadBoolean('animation',true);
        delay:=IniFile.ReadInteger('delay',15);
        IniFile.IniSection:='colors';
        Panel15.Color:=StringToColor(IniFile.ReadString('panel','$00FEE3DE'));
        PairSplitter1.Color:=StringToColor(IniFile.ReadString('kontrast','$00DE8F65'));
        StringGrid1.Color:=StringToColor(IniFile.ReadString('tabelle','$00FEE3DE'));
        Form1.Color:=StringToColor(IniFile.ReadString('band','$00FFF0EE'));
     end;
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
Var wohin:Char;
begin
    if (StringGrid1.Col<>0)and (StringGrid1.Row<>0) then
    begin
      if Form2.Execute then
      begin
         if Form2.EndZustand then
         begin
            StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:='- Ende -';
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
procedure TForm1.Timer1Timer(Sender: TObject);
var
  tempP: TPanel;
begin
  if animation then
  begin
       for i := 0 to Length(Band) - 1 do
        begin
          Band[i].Left := Band[i].Left - 1;
        end;
  end else
  begin
     for i := 0 to Length(Band) - 1 do
  begin
    Band[i].Left := Band[i].Left - 100;
  end;
  end;
  if Band[0].Left = temp - 100 then
  begin
    if bandContent.size-1 >= (zeiger+9) then
    begin
      band[0].Caption:=bandContent.getItem(zeiger+9);
    end
    else
    begin
      band[0].Caption:=leerzeichen;
      bandContent.addItem(leerzeichen);
    end;
    hasMoved:=true;
    timer1.Enabled := False;
    Inc(zeiger);
    tempP := Band[0];
    Band[0].Left := Band[0].Left + 1400;
    for i := 0 to Length(Band) - 2 do
    begin
      Band[i] := Band[i + 1];
    end;
    Band[Length(Band) - 1] := tempP;
  end;
end;

end.
