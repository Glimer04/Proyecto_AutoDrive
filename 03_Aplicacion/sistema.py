import tkinter as tk
from tkinter import messagebox, ttk
import mssql_python

# --- CONFIGURACIÓN DE LA CONEXIÓN A SQL SERVER ---
def obtener_conexion():
    try:
        conexion = mssql_python.connect(
            "Server=LAPTOP-4QFO4L3Q\\SQLEXPRESS;"
            "Database=AutoDriveDB;"
            "Trusted_Connection=yes;"
            "Encrypt=no;"
        )
        return conexion
    except Exception as e:
        messagebox.showerror("Error de Conexión", f"No se pudo conectar a la base de datos:\n{e}")
        return None

# --- VENTANA PRINCIPAL ---
ventana = tk.Tk()
ventana.title("AutoDrive S.R.L. - Sistema de Alquiler (SARV)")
ventana.geometry("900x600")
ventana.configure(bg="#F4F7F6")

# --- ESTILOS MODERNOS ---
estilo = ttk.Style()
estilo.theme_use('clam')
estilo.configure("TButton", font=("Segoe UI", 11), padding=8)
estilo.configure("TLabel", font=("Segoe UI", 12), background="#F4F7F6")
estilo.configure("Treeview.Heading", font=("Segoe UI", 10, "bold"))
estilo.configure("Treeview", font=("Segoe UI", 10), rowheight=25)

rol_usuario_actual = None
nombre_usuario_actual = ""

# --- VENTANA EMERGENTE DE SOPORTE ---
def abrir_ventana_soporte():
    win_soporte = tk.Toplevel(ventana)
    win_soporte.title("Contacto de Soporte / Nuevo Cliente")
    win_soporte.geometry("450x450")
    win_soporte.configure(bg="#F4F7F6")
    
    tk.Label(win_soporte, text="¿Necesitas ayuda?", font=("Segoe UI", 16, "bold"), bg="#F4F7F6", fg="#1a365d").pack(pady=10)
    tk.Label(win_soporte, text="Déjanos tu mensaje si olvidaste tus datos,\nno puedes entrar o si eres un cliente nuevo.", font=("Segoe UI", 10), bg="#F4F7F6", fg="gray").pack(pady=5)
    
    frame_form = tk.Frame(win_soporte, bg="#F4F7F6")
    frame_form.pack(pady=15, padx=20, fill="x")
    
    ttk.Label(frame_form, text="Tu Nombre:").pack(anchor="w")
    entry_nombre = ttk.Entry(frame_form)
    entry_nombre.pack(fill="x", pady=(0, 10))
    
    ttk.Label(frame_form, text="Tu Correo o Teléfono:").pack(anchor="w")
    entry_email = ttk.Entry(frame_form)
    entry_email.pack(fill="x", pady=(0, 10))
    
    ttk.Label(frame_form, text="Mensaje o Problema:").pack(anchor="w")
    entry_mensaje = tk.Text(frame_form, height=5, font=("Segoe UI", 10))
    entry_mensaje.pack(fill="x", pady=(0, 10))
    
    def enviar_mensaje():
        nom = entry_nombre.get()
        correo = entry_email.get()
        msj = entry_mensaje.get("1.0", tk.END).strip()
        
        if nom == "" or correo == "" or msj == "":
            messagebox.showwarning("Atención", "Por favor, llena todos los campos.")
            return
            
        conn = obtener_conexion()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute(
                    "INSERT INTO SolicitudesSoporte (SolicitudesSoporte_Nombre, SolicitudesSoporte_Email, SolicitudesSoporte_Mensaje) VALUES (?, ?, ?)",
                    (nom, correo, msj)
                )
                conn.commit()
                messagebox.showinfo("Mensaje Enviado", "Tu solicitud ha sido enviada a servicio al cliente.\nPronto nos pondremos en contacto contigo.")
                win_soporte.destroy()
            except Exception as e:
                messagebox.showerror("Error", f"No se pudo enviar el mensaje:\n{e}")
            finally:
                conn.close()

    btn_enviar = tk.Button(win_soporte, text="Enviar Mensaje", font=("Segoe UI", 11, "bold"), bg="#1a365d", fg="white", bd=0, cursor="hand2", command=enviar_mensaje)
    btn_enviar.pack(pady=10, fill="x", padx=20, ipady=5)

# --- FUNCIÓN DE LOGIN ---
def iniciar_sesion():
    global rol_usuario_actual, nombre_usuario_actual
    usuario = entry_usuario.get()
    clave = entry_clave.get()
    
    conexion = obtener_conexion()
    if conexion:
        cursor = conexion.cursor()
        cursor.execute("SELECT Usuarios_ID, Usuarios_Nombre, Roles_ID FROM Usuarios WHERE Usuarios_Nombre = ? AND Usuarios_Clave = ?", (usuario, clave))
        resultado = cursor.fetchone()
        
        if resultado:
            nombre_usuario_actual = resultado[1]
            rol_usuario_actual = resultado[2]
            
            messagebox.showinfo("Bienvenido", f"Acceso concedido a {nombre_usuario_actual}")
            abrir_menu_principal()
        else:
            messagebox.showerror("Error", "Usuario o contraseña incorrectos.")
        
        conexion.close()

# --- PANTALLA DE MENÚ PRINCIPAL (DASHBOARD) ---
def abrir_menu_principal():
    frame_login.pack_forget()
    frame_menu.pack(fill="both", expand=True)
    
    if rol_usuario_actual == 1:
        titulo = f"Panel de Administrador - Bienvenido {nombre_usuario_actual}"
    else:
        titulo = f"Panel de Agente - Bienvenido {nombre_usuario_actual}"
        
    tk.Label(frame_menu, text=titulo, font=("Segoe UI", 18, "bold"), bg="#1a365d", fg="white").pack(fill="x", pady=20)
    
    frame_botones = tk.Frame(frame_menu, bg="#F4F7F6")
    frame_botones.pack(pady=20)
    
    ttk.Button(frame_botones, text="Ver Vehículos Disponibles", command=abrir_pantalla_vehiculos).pack(pady=10)
    
    if rol_usuario_actual == 1:
        ttk.Button(frame_botones, text="Gestión de Clientes", command=abrir_pantalla_clientes).pack(pady=10)
        # Podríamos agregar un botón para que el admin vea los mensajes de soporte aquí
    
    ttk.Button(frame_botones, text="Cerrar Sesión", command=cerrar_sesion).pack(pady=30)

def cerrar_sesion():
    global rol_usuario_actual, nombre_usuario_actual
    rol_usuario_actual = None
    nombre_usuario_actual = ""
    
    for widget in frame_menu.winfo_children():
        widget.destroy()
        
    frame_menu.pack_forget()
    frame_login.pack(fill="both", expand=True)
    entry_usuario.delete(0, tk.END)
    entry_clave.delete(0, tk.END)

# --- PANTALLA DE GESTIÓN DE CLIENTES ---
def abrir_pantalla_clientes():
    ventana_cli = tk.Toplevel(ventana)
    ventana_cli.title("Gestión de Clientes")
    ventana_cli.geometry("700x500")
    ventana_cli.configure(bg="#F4F7F6")
    
    frame_form = tk.Frame(ventana_cli, bg="#F4F7F6")
    frame_form.pack(pady=15)
    
    ttk.Label(frame_form, text="Cédula:").grid(row=0, column=0, padx=5, pady=5, sticky="e")
    entry_cedula = ttk.Entry(frame_form)
    entry_cedula.grid(row=0, column=1, padx=5, pady=5)
    
    ttk.Label(frame_form, text="Nombre:").grid(row=0, column=2, padx=5, pady=5, sticky="e")
    entry_nombre = ttk.Entry(frame_form)
    entry_nombre.grid(row=0, column=3, padx=5, pady=5)
    
    ttk.Label(frame_form, text="Licencia:").grid(row=1, column=0, padx=5, pady=5, sticky="e")
    entry_licencia = ttk.Entry(frame_form)
    entry_licencia.grid(row=1, column=1, padx=5, pady=5)
    
    tree = ttk.Treeview(ventana_cli, columns=("ID", "Cédula", "Nombre", "Licencia"), show="headings")
    tree.heading("ID", text="ID")
    tree.heading("Cédula", text="Cédula")
    tree.heading("Nombre", text="Nombre")
    tree.heading("Licencia", text="Licencia")
    
    tree.column("ID", width=50, anchor="center")
    tree.column("Cédula", width=150, anchor="center")
    tree.column("Nombre", width=200)
    tree.column("Licencia", width=150, anchor="center")
    
    tree.pack(fill="both", expand=True, padx=20, pady=10)
    
    def cargar_clientes():
        for item in tree.get_children(): tree.delete(item)
        conn = obtener_conexion()
        if conn:
            cursor = conn.cursor()
            cursor.execute("SELECT Clientes_ID, Clientes_Cedula, Clientes_Nombre, Clientes_Licencia FROM Clientes")
            for row in cursor.fetchall():
                tree.insert("", tk.END, values=[str(val) for val in row])
            conn.close()
            
    def guardar_cliente():
        conn = obtener_conexion()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO Clientes (Clientes_Cedula, Clientes_Nombre, Clientes_Licencia) VALUES (?, ?, ?)",
                               (entry_cedula.get(), entry_nombre.get(), entry_licencia.get()))
                conn.commit()
                messagebox.showinfo("Éxito", "Cliente guardado correctamente.")
                entry_cedula.delete(0, tk.END)
                entry_nombre.delete(0, tk.END)
                entry_licencia.delete(0, tk.END)
                cargar_clientes()
            except Exception as e:
                messagebox.showerror("Error", f"No se pudo guardar: {e}")
            finally:
                conn.close()

    ttk.Button(ventana_cli, text="Guardar Cliente", command=guardar_cliente).pack(pady=10)
    cargar_clientes()

# --- PANTALLA DE GESTIÓN DE VEHÍCULOS ---
def abrir_pantalla_vehiculos():
    ventana_veh = tk.Toplevel(ventana)
    ventana_veh.title("Vehículos Disponibles (Vista)")
    ventana_veh.geometry("700x400")
    ventana_veh.configure(bg="#F4F7F6")
    
    tk.Label(ventana_veh, text="Catálogo de Vehículos Listos para Alquilar", font=("Segoe UI", 14, "bold"), bg="#F4F7F6", fg="#1a365d").pack(pady=10)
    
    tree = ttk.Treeview(ventana_veh, columns=("Placa", "Marca", "Categoria", "Precio"), show="headings")
    tree.heading("Placa", text="Placa")
    tree.heading("Marca", text="Marca")
    tree.heading("Categoria", text="Categoría")
    tree.heading("Precio", text="Precio Diario (US$)")
    
    tree.column("Placa", width=100, anchor="center")
    tree.column("Marca", width=150, anchor="center")
    tree.column("Categoria", width=150, anchor="center")
    tree.column("Precio", width=120, anchor="center")
    
    tree.pack(fill="both", expand=True, padx=20, pady=10)
    
    conn = obtener_conexion()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Vista_VehiculosDisponibles")
        for row in cursor.fetchall():
            datos_limpios = [str(valor) for valor in row]
            tree.insert("", tk.END, values=datos_limpios)
        conn.close()

# --- ESTRUCTURA DE LA PANTALLA DE LOGIN ---
frame_login = tk.Frame(ventana, bg="#F4F7F6")
frame_login.pack(fill="both", expand=True)

# Tarjeta de Login centrada
tarjeta_login = tk.Frame(frame_login, bg="white", bd=1, relief="solid")
tarjeta_login.place(relx=0.5, rely=0.5, anchor="center", width=350, height=450) # Aumentamos un poco el alto

tk.Label(tarjeta_login, text="AutoDrive S.R.L.", font=("Segoe UI", 24, "bold"), bg="white", fg="#1a365d").pack(pady=(30, 5))
tk.Label(tarjeta_login, text="Sistema de Alquiler de Vehículos", font=("Segoe UI", 10), bg="white", fg="gray").pack(pady=(0, 20))

ttk.Label(tarjeta_login, text="Usuario:", background="white").pack(anchor="w", padx=40)
entry_usuario = ttk.Entry(tarjeta_login)
entry_usuario.pack(pady=5, padx=40, fill="x")

ttk.Label(tarjeta_login, text="Contraseña:", background="white").pack(anchor="w", padx=40, pady=(10,0))
entry_clave = ttk.Entry(tarjeta_login, show="*")
entry_clave.pack(pady=5, padx=40, fill="x")

btn_login = tk.Button(tarjeta_login, text="Iniciar Sesión", font=("Segoe UI", 12, "bold"), bg="#1a365d", fg="white", bd=0, cursor="hand2", command=iniciar_sesion)
btn_login.pack(pady=20, padx=40, fill="x", ipady=5)

# BOTÓN DE SOPORTE
btn_soporte = tk.Button(tarjeta_login, text="¿Problemas para entrar o cliente nuevo?\nContactar a Soporte Técnico", 
                        font=("Segoe UI", 9, "underline"), bg="white", fg="#0066cc", bd=0, cursor="hand2", command=abrir_ventana_soporte)
btn_soporte.pack(pady=10)

frame_menu = tk.Frame(ventana, bg="#F4F7F6")

ventana.mainloop()
