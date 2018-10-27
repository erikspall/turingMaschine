unit maschineThread;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, EditBtn, Grids;

Type

    { TMyThread }

    TMyThread = class(TThread)
    private
      fStatusText : string;

    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
      procedure moveForward();
      procedure moveBackward();
      procedure Timer1Timer(Sender: TObject);
      Var Timer1: TTimer;
    Timer2: TTimer;

    end;
implementation

uses tMaschine;


constructor TMyThread.Create(CreateSuspended : boolean);
  begin
    FreeOnTerminate := True;
    inherited Create(CreateSuspended);
    Timer1.Interval:=100;
    Timer2.Interval:=100;
    Timer1.OnTimer:=@Timer1Timer;
  end;
Var temp,i:Integer;
  hasErw:Boolean;
procedure TMyThread.moveForward();
begin
  if Form1.hasMoved then begin
  //ShowMessage('Bewegen');
  Form1.hasMoved:=false;
  temp := Form1.Band[0].Left;
  Form1.Timer1.Enabled := True;
                     end else
                     begin
  //            ShowMessage('nicht Bewegen');
                     end;

end;

procedure TMyThread.moveBackward();
begin
  temp := Form1.Band[0].Left;
  hasErw := False;



  Form1.Timer2.Enabled := True;
end;

procedure TMyThread.Timer1Timer(Sender: TObject);
var
  tempP: TPanel;
begin

  for i := 0 to Length(Form1.Band) - 1 do
  begin
    Form1.Band[i].Left := Form1.Band[i].Left - 1;
  end;

  if Form1.Band[0].Left = temp - 100 then
  begin
    if Form1.bandContent.size-1 >= (Form1.zeiger+9) then
    begin
      Form1.band[0].Caption:=Form1.bandContent.getItem(Form1.zeiger+9);
    end
    else
    begin
      Form1.band[0].Caption:=Form1.leerzeichen;
      Form1.bandContent.addItem(Form1.leerzeichen);
    end;

    timer1.Enabled := False;
     Form1.hasMoved:=true;
    Inc(Form1.zeiger);
    //Form1.debugListBox;
    tempP := Form1.Band[0];

    Form1.Band[0].Left := Form1.Band[0].Left + 1400;
    for i := 0 to Length(Form1.Band) - 2 do
    begin
      Form1.Band[i] := Form1.Band[i + 1];

    end;
    Form1.Band[Length(Form1.Band) - 1] := tempP;



  end;

end;



  procedure TMyThread.Execute;
  var
    newStatus : string;
  begin
    Timer1.Interval:=10;
    Timer2.Interval:=10;
    while (not Terminated)(* and (Form1.hasMoved)*) do
      begin

        moveForward();


      end;
  end;
end.

