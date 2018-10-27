unit tMaschine;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,obtlist;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
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
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel15Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure moveForward();

    procedure moveBackwards();
    procedure Timer2Timer(Sender: TObject);
    function whatCaption(Var woZeiger:Integer):Char;
    procedure debugListBox();
  private

  public

  end;

var
  Form1: TForm1;
  Band: array[0..13] of TPanel;
  i, zeiger: integer;
  temp: integer;
  hasErw: boolean;
  bandContent: StringList;

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
  for i:=0 to Length(Edit1.Text)-1 do
  begin
     if i+5 > bandContent.size then
     begin
       bandContent.addItem(Edit1.Text[i+1]);
     end
     else
     begin
        bandContent.replaceItem(i+5,Edit1.Text[i+1]);
     end;
  end;
  debugListBox;
end;

procedure TForm1.moveForward();

begin
  temp := Band[0].Left;
  Form1.Timer1.Enabled := True;



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
      band[Length(Band)-1].Caption:='#';
      bandContent.insertItem('#',0);
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

procedure TForm1.moveBackwards();
begin
  temp := Band[0].Left;
  hasErw := False;



  Form1.Timer2.Enabled := True;

  end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  bandContent.Create;
  Self.DoubleBuffered := True;
  zeiger := 5;
  for i := 0 to 13 do
  begin
    Band[i] := TPanel(Form1.FindComponent('Panel' + (i + 1).ToString));
    Band[i].DoubleBuffered := True;
    bandContent.addItem('#');

  end;
    debugListBox;
end;

procedure TForm1.Panel15Click(Sender: TObject);
begin

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
      band[0].Caption:='#';
      bandContent.addItem('#');
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
