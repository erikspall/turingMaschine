unit tm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

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
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
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
    procedure joinArray();
    procedure moveBackwards();
    procedure Timer2Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Band: array[0..13] of TPanel;
  i, zeiger: integer;
  temp: integer;
  hasErw: boolean;
  bandContent, bandContentNegativ,bandContentAll: array of char;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

begin
  ListBox3.Clear;
  ListBox2.Clear;

  zeiger := zeiger + 1;
  moveForward();
  if (zeiger >= 0) and (zeiger + 1 > Length(BandContent)) then
  begin
    SetLength(BandContent, Length(BandContent) + 1);
    bandContent[Length(bandContent) - 1] := '#';

  end;
  for i := 0 to Length(BandContent) - 1 do
  begin
    ListBox2.Items.add(BandContent[i]);
  end;
  joinArray();
  for i:=0 to Length(bandContentAll)-1 do
  begin
    ListBox3.Items.Add(bandContentAll[i]);
  end;
  ListBox3.ItemIndex:=zeiger;

  if Length(BandContentAll)>=zeiger+8 then
  begin
  if bandContentAll[zeiger+8] = '' then
  begin

    ShowMessage('Das ist Leer');
    band[Length(band)-1].Caption:='#';
  end
  else
  begin
    band[Length(band)-1].Caption:=bandContentAll[zeiger+8];
    ShowMessage('Das ist Voll');

  end;
  end
  else
  begin
         band[Length(band)-1].Caption:='#';
  end;
   ShowMEssage(zeiger.toString);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  tempC: char;
begin
  Listbox1.Clear;
  ListBox3.Clear;
  if Length(BandContentAll)>=zeiger-6 then
  begin
  if bandContentAll[Length(bandContentAll)-1-zeiger] = '' then
  begin
    band[Length(band)-1].Caption:=bandContentAll[Length(bandContentAll)-1-zeiger];
   // ShowMessage('Das ist Voll');
  end
  else
  begin

    //ShowMessage('Das ist Leer');
    band[0].Caption:='#';
  end;

  end
  else
  begin
     band[0].Caption:='#';
  end;
  moveBackwards();
  if (zeiger <= 0) and (zeiger - 1 < -Length(BandContentNegativ)) then
  begin
    SetLength(BandContentNegativ, Length(BandContentNegativ) + 1);
    Inc(Zeiger);
    bandContentNegativ[Length(bandContentNegativ) - 1] := '#';
  end
  else
  begin
    zeiger := zeiger - 1;
  end;
  for i := 0 to Length(BandContentNegativ) - 1 do
  begin
    ListBox1.Items.add(BandContentNegativ[i]);
  end;

  joinArray();
   for i:=0 to Length(bandContentAll)-1 do
  begin
    ListBox3.Items.Add(bandContentAll[i]);
  end;
   ListBox3.ItemIndex:=zeiger-1;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  tempS: string;
begin
  temps := Edit1.Text;
  for i := 0 to LEngth(tempS) - 1 do
  begin
    SetLength(bandContent, Length(bandContent) + 1);
    bandContent[i] := tempS[i + 1];
  end;
  for i := 0 to Length(tempS) - 1 do
  begin
    band[i + 5].Caption := bandContent[i];
  end;
end;

procedure TForm1.moveForward();

begin
  temp := Band[0].Left;
  Form1.Timer1.Enabled := True;
 // bandContentAll:=bandContentNegativ+bandContent;


end;

procedure TForm1.joinArray();
begin
  Setlength(bandContentAll,0);
  for i:=0 to Length(BandContentNegativ)-1 do
  begin
   // ShowMessage('');
     SetLength(BandContentAll,Length(bandContentAll)+1);
     bandContentAll[i]:=bandContentnegativ[(Length(bandContentNegativ)-1)-i];
  end;
  for i:=0 to Length(bandContent)-1 do
  begin
     SetLength(BandContentAll,Length(bandContentAll)+1);
     bandContentAll[Length(bandContentAll)-1]:=bandContent[i];
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

    Band[Length(Band) - 1].Left := Band[Length(Band) - 1].Left - 1400;
    (*if zeiger <= 0 then
    begin
      if -Length(BandContentNegativ) <= zeiger - 7 then
      begin
        Band[Length(Band)-1].Caption := BandContentNegativ[zeiger - 7];
      end
      else
      begin
        Band[Length(Band)-1].Caption := '#';
      end;
    end
    else
    begin
      if Length(BandContent) >= zeiger + 8 then
      begin
        Band[0].Caption := BandContent[zeiger + 8];
      end
      else
      begin
        Band[0].Caption := '#';
      end;
    end; *)
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

  Self.DoubleBuffered := True;
  zeiger := 0;
  for i := 0 to 13 do
  begin
    Band[i] := TPanel(Form1.FindComponent('Panel' + (i + 1).ToString));
    Band[i].DoubleBuffered := True;
    //Band[i].Caption:=(i+1).tosTring;
  end;
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

    timer1.Enabled := False;
    tempP := Band[0];

    Band[0].Left := Band[0].Left + 1400;
   (* if zeiger >= 0 then
    begin
      if Length(BandContent) >= zeiger + 8 then
      begin
        Band[0].Caption := BandContent[zeiger + 8];
      end
      else
      begin
        Band[0].Caption := '#';
      end;
    end
    else
    begin
      if -Length(BandContentNegativ) <= zeiger - 7 then
      begin
        Band[Length(Band)-1].Caption := BandContentNegativ[zeiger - 7];
      end
      else
      begin
        Band[Length(Band)-1].Caption := '#';
      end;
    end;   *)

    for i := 0 to Length(Band) - 2 do
    begin
      Band[i] := Band[i + 1];

    end;
    Band[Length(Band) - 1] := tempP;



  end;

end;

end.
