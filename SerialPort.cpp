/*
*
*  Under GPL License
*
*/

#include "SerialPort.h"
#include <QDebug>

SerialPort::SerialPort(QQuickItem *parent):
	QQuickItem(parent)
{
    //m_availablePorts = QList<QString>();
    foreach (const QSerialPortInfo &port, QSerialPortInfo::availablePorts()){
        QString rt = QString(port.portName());
        m_availablePorts << rt;
    }
    std::fill(m_temperature, m_temperature + 8, 0);
}

QStringList SerialPort::getAvailablePorts()
{
    return m_availablePorts;
}

 void SerialPort::setup(const QString portName, int baudRate){
	 m_serial.setPortName(portName);
     m_serial.setBaudRate(baudRate);
 }

 bool SerialPort::open(QFile::OpenMode mode){
     m_serial.setDataBits(QSerialPort::Data8);
     m_serial.setParity(QSerialPort::Parity::NoParity);
     m_serial.setStopBits(QSerialPort::StopBits::OneStop);
     m_serial.setFlowControl(QSerialPort::FlowControl::NoFlowControl);
     if (m_serial.open(QIODevice::ReadWrite)) {

     } else {
//         QMessageBox::critical(this, tr("Error"), m_serial->errorString());
         return false;
//         showStatusMessage(tr("Open error"));
     }
     return true;
 }

 void SerialPort::close(){
	 m_serial.close();
 }

 QString	SerialPort::read(qint64 maxSize){
	 qint64 cnt;
	 char *buf;

     buf = new char[maxSize];
	 cnt = m_serial.read(buf, maxSize);

	 return QString::fromUtf8(buf, cnt);
 }

 QByteArray SerialPort::readData()
 {
     QByteArray result;
     uint16_t res[8];
     if (m_serial.bytesAvailable() > 60)
             {
                 result = m_serial.readAll();
                 if (result.size() > 0)
                 {
                     for (int i = 0; i < result.size(); i++)
                     {
                         if (result[i] == 'A' && result[i+1] == 'D' && result[i+2] == 'N')
                         {
                             res[0] = (result[i+3] << 8 & 0xFF00) | (result[i+4] & 0x00FF);
                             res[1] = (result[i+5] << 8 & 0xFF00) | (result[i+6] & 0x00FF);
                             res[2] = (result[i+7] << 8 & 0xFF00) | (result[i+8] & 0x00FF);
                             res[3] = (result[i+9] << 8 & 0xFF00) | (result[i+10] & 0x00FF);
                             res[4] = (result[i+11] << 8 & 0xFF00) | (result[i+12] & 0x00FF);
                             res[5] = (result[i+13] << 8 & 0xFF00) | (result[i+14] & 0x00FF);
                             res[6] = (result[i+15] << 8 & 0xFF00) | (result[i+16] & 0x00FF);
                             res[7] = (result[i+17] << 8 & 0xFF00) | (result[i+18] & 0x00FF);

                             //(GAIN_TWOTHIRDS) 2/3x gain +/- 6.144V  1 bit =   0.1875mV (default)
                             m_temperature[0] = (res[0] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[1] = (res[1] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[2] = (res[2] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[3] = (res[3] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[4] = (res[4] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[5] = (res[5] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[6] = (res[6] * 0.0001875 -6.144) * 100 / 12;
                             m_temperature[7] = (res[7] * 0.0001875 -6.144) * 100 / 12;
                             qDebug() << "Result------------";
                             qDebug() << static_cast<int>(res[0]);
                             qDebug() << res[1];
                             qDebug() << res[2];
                             qDebug() << res[3];
                             qDebug() << res[4];
                             qDebug() << res[5];
                             qDebug() << res[6];
                             qDebug() << res[7];
                             break;
                         }

                     }
                 }
             }

     return result;
 }


 float SerialPort::getTemperatureAt(int index){
     return m_temperature[index];
 }
 QString	SerialPort::readLine(qint64 maxSize){
	 qint64 cnt;
	 char *buf;

     buf = new char[maxSize];
	 cnt = m_serial.readLine(buf, maxSize);

	 return QString::fromUtf8(buf, cnt);
 }

 bool	SerialPort::write(QString s){
	 return s.length() ==  m_serial.write(s.toUtf8());
 }

 bool	SerialPort::writeLine(QString s){
	 return write(s + serialEOL);
 }

