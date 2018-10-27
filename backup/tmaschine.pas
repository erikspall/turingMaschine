unit tMaschine;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, EditBtn, Grids,obtlist, inputDialogforTM;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Edit1: TEdit;
    EditButton1: TEditButton;
    Image1: TImage;
    Label3: TLabel;
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel15Click(Sender: TObject);
   procedure StringGrid1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure moveForward();
    procedure initBand();
    procedure moveBackwards();
    procedure Timer2Timer(Sender: TObject);
    function whatCaption(Var woZeiger:Integer):Char;
    procedure debugListBox();
    procedure prepareStringGrid();

  private

  public

  end;

var
  Form1: TForm1;
  Band: array[0..13] of TPanel;
  i, zeiger,k: integer;
  temp: integer;
  hasErw: boolean;
  bandContent: StringList;
  leerzeichen:char;
   MaschineAl: StringList;
   Zustand2:Array of Integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

begin

  moveForward();

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  moveBackwards();

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
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
  debugListBox;
  PrepareStringGrid;

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

end;

procedure TForm1.EditButton1Change(Sender: TObject);
begin

end;

procedure TForm1.moveForward();

begin
  temp := Band[0].Left;
  Form1.Timer1.Enabled := True;



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

  for i := 0 to Length(Band) - 1 do
  begin
    Band[i].Left := Band[i].Left + 1;
  end;


  if Band[1].Left = temp + 100 then
  begin

    timer2.Enabled := False;
    Dec(Zeiger);
    debugListBox;

  end;

end;

function TForm1.whatCaption(var woZeiger: Integer): Char;
begin

end;

procedure TForm1.debugListBox();
begin
  ListBox1.Clear;
  for i:=0 to bandContent.size()-1 do
  begin
    ListBox1.Items.Add(bandContent.getItem(i));
  end;
  Label3.Caption:=Zeiger.ToString;
  ListBox1.ItemIndex:=Zeiger;
end;

procedure TForm1.prepareStringGrid();
Var rawA,tempStr:String;
  C:Char;
  Col,Col2:Integer;
  j:Integer;
  isIn:Boolean;
begin
   rawA:=Edit1.Text;

   isIn:=false;
   StringGrid1.ColCount:=2;

   StringGrid1.Cells[1,0]:=leerzeichen;
   for j:=1 to Length(rawA) do
   begin
        for Col:=1 to StringGrid1.ColCount-1 do
        begin
          if rawA[j] = StringGrid1.Cells[Col,0] then
          begin
            isIn:=true;

          end;
        end;

        if not isIn then
        begin
          StringGrid1.ColCount:=StringGrid1.ColCount+1;
          StringGrid1.Cells[Col+1,0]:=rawA[j];
           Inc(Col);
           isIn:=false;
        end;
   end;

   StringGrid1.RowCount:=Length(Zustand2);

   for i:=1 to StringGrid1.RowCount-1 do
   begin
     StringGrid1.Cells[0,i]:='Z'+Zustand2[i].toString;
   end;



end;

procedure TForm1.moveBackwards();
begin
  temp := Band[0].Left;
  hasErw := False;



  Form1.Timer2.Enabled := True;

  end;


procedure TForm1.FormCreate(Sender: TObject);
begin


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
    debugListBox;


      SetLength(Zustand2,Length(Zustand2)+1);
     Zustand2[Length(Zustand2)]:=1;

   end;


procedure TForm1.Panel15Click(Sender: TObject);
begin

end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin


    if Form2.Execute then
    begin

    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  tempP: TPanel;
begin

  for i := 0 to Length(Band) - 1 do
  begin
    Band[i].Left := Band[i].Left - 1;
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
    timer1.Enabled := False;
    Inc(zeiger);
    debugListBox;
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
