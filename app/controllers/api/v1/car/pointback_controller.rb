class Api::V1::Car::PointbackController < Api::V1::ApiController
  # /api/v1/car/pointback?id=AAA:1&cid=8&cname=%83%7C%83C%83%93%83g%83o%83b%83N%83e%83X%83g%97p123&carrier=1&click_date=20141017220805&action_date20141017220810&amount=0&commission=4&aff_id=OtQkeRK213551285&point=4&pid=1
  def index
    remote_ip = get_remote_id
    if car_ip?(remote_ip)
      reward!
      render text: 'OK', status: 200
    else
      redirect_to app_car_error_index_path
    end
  end

  private

  def pointback_params
    params.permit(:id, :cid, :cname, :carrier, :click_date, :action_date, :amount, :commission, :aff_id, :point, :pid)
  end

  def get_remote_id
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  def car_ip?(ip)
    Settings.car.ip.include? ip
  end

  def reward!
    p = pointback_params
    id, p[:item_id] = p[:id].split(':')
    p[:cname].encode!('UTF-8', 'Shift_JIS')
    device = Device.find(id)
    p[:device_id] = device.id
    p.delete(:id)
    RewardHistory.create! p
    PurchasedItem.create! key: device.key, item_id: p[:item_id]
  end
end
